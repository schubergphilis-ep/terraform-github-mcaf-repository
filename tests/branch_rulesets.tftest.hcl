mock_provider "github" {}

run "setup" {
  module {
    source = "./tests/setup"
  }
}

run "classic_by_default" {
  variables {
    name = "rulesets-${run.setup.random_string}"
  }

  module {
    source = "./"
  }

  command = plan

  assert {
    condition     = length(resource.github_branch_protection.default) == 1
    error_message = "Classic branch protection should be used by default"
  }

  assert {
    condition     = length(resource.github_repository_ruleset.branches) == 0
    error_message = "No branch rulesets should be created by default"
  }
}

run "ruleset_default" {
  variables {
    name                   = "rulesets-${run.setup.random_string}"
    branch_protection_type = "ruleset"

    branches = {
      develop = {}
      feature = { use_branch_protection = false }
    }
  }

  module {
    source = "./"
  }

  command = plan

  assert {
    condition     = length(resource.github_branch_protection.default) == 0
    error_message = "Classic branch protection should not be created in ruleset mode"
  }

  assert {
    condition     = length(resource.github_branch.default) == 3
    error_message = "Branches should still be created in ruleset mode"
  }

  assert {
    condition     = keys(resource.github_repository_ruleset.branches) == ["Branch protection"]
    error_message = "Only the default ruleset should be created"
  }

  assert {
    condition     = toset(resource.github_repository_ruleset.branches["Branch protection"].conditions[0].ref_name[0].include) == toset(["refs/heads/develop", "refs/heads/main"])
    error_message = "Default ruleset should target every protected branch"
  }

  assert {
    condition     = length(resource.github_repository_ruleset.branches["Branch protection"].conditions[0].ref_name[0].exclude) == 0
    error_message = "Default ruleset should not exclude branches"
  }

  assert {
    condition = (
      length(resource.github_repository_ruleset.branches["Branch protection"].bypass_actors) == 2 &&
      resource.github_repository_ruleset.branches["Branch protection"].bypass_actors[0].actor_type == "RepositoryRole" &&
      resource.github_repository_ruleset.branches["Branch protection"].bypass_actors[0].actor_id == 5 &&
      resource.github_repository_ruleset.branches["Branch protection"].bypass_actors[0].bypass_mode == "always" &&
      resource.github_repository_ruleset.branches["Branch protection"].bypass_actors[1].actor_type == "OrganizationAdmin" &&
      resource.github_repository_ruleset.branches["Branch protection"].bypass_actors[1].bypass_mode == "always"
    )
    error_message = "Repository and organization admins should be able to bypass the default ruleset"
  }

  assert {
    condition = (
      resource.github_repository_ruleset.branches["Branch protection"].rules[0].deletion == true &&
      resource.github_repository_ruleset.branches["Branch protection"].rules[0].non_fast_forward == true &&
      resource.github_repository_ruleset.branches["Branch protection"].rules[0].required_signatures == true
    )
    error_message = "Default ruleset should block deletion and force pushes and require signatures"
  }

  assert {
    condition     = resource.github_repository_ruleset.branches["Branch protection"].rules[0].pull_request[0].required_approving_review_count == 1
    error_message = "Default required_approving_review_count does not match"
  }

  assert {
    condition = (
      resource.github_repository_ruleset.branches["Branch protection"].rules[0].pull_request[0].require_code_owner_review == true &&
      resource.github_repository_ruleset.branches["Branch protection"].rules[0].pull_request[0].dismiss_stale_reviews_on_push == true
    )
    error_message = "Default code owner and stale review settings do not match"
  }

  assert {
    condition     = length(resource.github_repository_ruleset.branches["Branch protection"].rules[0].required_status_checks) == 0
    error_message = "No status checks should be required by default"
  }
}

run "ruleset_no_bypass" {
  variables {
    name                   = "rulesets-${run.setup.random_string}"
    branch_protection_type = "ruleset"

    branch_rulesets = {
      strict = {
        bypass_actors = []
      }
    }
  }

  module {
    source = "./"
  }

  command = plan

  assert {
    condition     = length(resource.github_repository_ruleset.branches["strict"].bypass_actors) == 0
    error_message = "Setting bypass_actors to [] should remove the admin bypass"
  }

  assert {
    condition     = length(resource.github_repository_ruleset.branches["strict"].rules[0].pull_request) == 0
    error_message = "Pull requests should only be required when rules.pull_request is set"
  }
}

run "ruleset_custom" {
  variables {
    name                   = "rulesets-${run.setup.random_string}"
    branch_protection_type = "ruleset"

    branch_rulesets = {
      managed = {
        rules = {
          pull_request = {
            required_approving_review_count = 2
            require_code_owner_review       = false
          }

          required_status_checks = {
            strict_required_status_checks_policy = true

            required_checks = [
              { context = "lint" },
              { context = "test", integration_id = 15368 },
            ]
          }
        }
      }

      release = {
        bypass_actors = [
          { actor_id = 5, actor_type = "RepositoryRole", bypass_mode = "pull_request" },
        ]

        conditions = {
          ref_name = {
            include = ["refs/heads/release/**"]
            exclude = ["refs/heads/release/old"]
          }
        }

        rules = {
          required_signatures = false

          required_deployment_environments = ["staging"]
        }
      }
    }
  }

  module {
    source = "./"
  }

  command = plan

  assert {
    condition     = keys(resource.github_repository_ruleset.branches) == ["managed", "release"]
    error_message = "Custom rulesets should replace the default"
  }

  assert {
    condition     = resource.github_repository_ruleset.branches["managed"].conditions[0].ref_name[0].include == tolist(["refs/heads/main"])
    error_message = "Ruleset without conditions should target the protected branches"
  }

  assert {
    condition     = resource.github_repository_ruleset.branches["release"].conditions[0].ref_name[0].include == tolist(["refs/heads/release/**"])
    error_message = "Ruleset include does not match"
  }

  assert {
    condition     = resource.github_repository_ruleset.branches["release"].conditions[0].ref_name[0].exclude == tolist(["refs/heads/release/old"])
    error_message = "Ruleset exclude does not match"
  }

  assert {
    condition = (
      length(resource.github_repository_ruleset.branches["release"].bypass_actors) == 1 &&
      resource.github_repository_ruleset.branches["release"].bypass_actors[0].bypass_mode == "pull_request"
    )
    error_message = "Bypass actors do not match"
  }

  assert {
    condition     = resource.github_repository_ruleset.branches["release"].rules[0].required_signatures == false
    error_message = "required_signatures does not match"
  }

  assert {
    condition     = resource.github_repository_ruleset.branches["release"].rules[0].non_fast_forward == true
    error_message = "Force pushes should be blocked unless disabled"
  }

  assert {
    condition     = resource.github_repository_ruleset.branches["release"].rules[0].required_deployments[0].required_deployment_environments == tolist(["staging"])
    error_message = "Required deployments do not match"
  }

  assert {
    condition     = resource.github_repository_ruleset.branches["managed"].rules[0].pull_request[0].required_approving_review_count == 2
    error_message = "required_approving_review_count does not match"
  }

  assert {
    condition     = resource.github_repository_ruleset.branches["managed"].rules[0].required_status_checks[0].strict_required_status_checks_policy == true
    error_message = "strict_required_status_checks_policy does not match"
  }

  assert {
    condition     = length(resource.github_repository_ruleset.branches["managed"].rules[0].required_status_checks[0].required_check) == 2
    error_message = "Required checks do not match"
  }

  assert {
    condition     = length(resource.github_repository_ruleset.branches["managed"].rules[0].required_deployments) == 0
    error_message = "No required deployments should be set"
  }
}

run "ruleset_no_protected_branches" {
  variables {
    name                   = "rulesets-${run.setup.random_string}"
    branch_protection_type = "ruleset"

    branches = {
      main = { use_branch_protection = false }
    }
  }

  module {
    source = "./"
  }

  command = plan

  assert {
    condition     = length(resource.github_repository_ruleset.branches) == 0
    error_message = "Rulesets without conditions should be skipped when no branch is protected"
  }
}

run "ruleset_rejects_branch_protection" {
  variables {
    name                   = "rulesets-${run.setup.random_string}"
    branch_protection_type = "ruleset"

    branches = {
      develop = {
        branch_protection = {
          required_reviews = { required_approving_review_count = 1 }
        }
      }
    }
  }

  module {
    source = "./"
  }

  command = plan

  expect_failures = [
    var.branches,
  ]
}

run "ruleset_rejects_empty_required_checks" {
  variables {
    name                   = "rulesets-${run.setup.random_string}"
    branch_protection_type = "ruleset"

    branch_rulesets = {
      checks = {
        rules = {
          required_status_checks = { required_checks = [] }
        }
      }
    }
  }

  module {
    source = "./"
  }

  command = plan

  expect_failures = [
    var.branch_rulesets,
  ]
}

run "ruleset_rejects_unknown_type" {
  variables {
    name                   = "rulesets-${run.setup.random_string}"
    branch_protection_type = "rulesets"
  }

  module {
    source = "./"
  }

  command = plan

  expect_failures = [
    var.branch_protection_type,
  ]
}

run "ruleset_merge_queue" {
  variables {
    name                   = "rulesets-${run.setup.random_string}"
    branch_protection_type = "ruleset"
    merge_strategy         = "squash"

    branch_rulesets = {
      "Branch protection" = {
        rules = {
          pull_request = {}

          merge_queue = {
            grouping_strategy = "HEADGREEN"
          }
        }
      }
    }
  }

  module {
    source = "./"
  }

  command = plan

  assert {
    condition = (
      length(resource.github_repository_ruleset.branches["Branch protection"].rules[0].merge_queue) == 1 &&
      resource.github_repository_ruleset.branches["Branch protection"].rules[0].merge_queue[0].grouping_strategy == "HEADGREEN" &&
      resource.github_repository_ruleset.branches["Branch protection"].rules[0].merge_queue[0].merge_method == "SQUASH" &&
      resource.github_repository_ruleset.branches["Branch protection"].rules[0].merge_queue[0].check_response_timeout_minutes == 60 &&
      resource.github_repository_ruleset.branches["Branch protection"].rules[0].merge_queue[0].max_entries_to_build == 5 &&
      resource.github_repository_ruleset.branches["Branch protection"].rules[0].merge_queue[0].max_entries_to_merge == 5 &&
      resource.github_repository_ruleset.branches["Branch protection"].rules[0].merge_queue[0].min_entries_to_merge == 1 &&
      resource.github_repository_ruleset.branches["Branch protection"].rules[0].merge_queue[0].min_entries_to_merge_wait_minutes == 5
    )
    error_message = "Merge queue should use the given settings and GitHub's defaults for the rest"
  }
}

run "ruleset_no_merge_queue_by_default" {
  variables {
    name                   = "rulesets-${run.setup.random_string}"
    branch_protection_type = "ruleset"
  }

  module {
    source = "./"
  }

  command = plan

  assert {
    condition     = length(resource.github_repository_ruleset.branches["Branch protection"].rules[0].merge_queue) == 0
    error_message = "The default ruleset should not require a merge queue"
  }
}

run "ruleset_merge_queue_boundaries" {
  variables {
    name                   = "rulesets-${run.setup.random_string}"
    branch_protection_type = "ruleset"

    branch_rulesets = {
      queue = {
        rules = {
          pull_request = {}

          merge_queue = {
            check_response_timeout_minutes    = 360
            max_entries_to_build              = 100
            max_entries_to_merge              = 100
            min_entries_to_merge              = 0
            min_entries_to_merge_wait_minutes = 0
          }
        }
      }
    }
  }

  module {
    source = "./"
  }

  command = plan

  assert {
    condition = (
      resource.github_repository_ruleset.branches["queue"].rules[0].merge_queue[0].check_response_timeout_minutes == 360 &&
      resource.github_repository_ruleset.branches["queue"].rules[0].merge_queue[0].max_entries_to_build == 100 &&
      resource.github_repository_ruleset.branches["queue"].rules[0].merge_queue[0].max_entries_to_merge == 100 &&
      resource.github_repository_ruleset.branches["queue"].rules[0].merge_queue[0].min_entries_to_merge == 0 &&
      resource.github_repository_ruleset.branches["queue"].rules[0].merge_queue[0].min_entries_to_merge_wait_minutes == 0 &&
      resource.github_repository_ruleset.branches["queue"].rules[0].merge_queue[0].merge_method == "MERGE"
    )
    error_message = "Merge queue settings at the edges of GitHub's allowed ranges should be accepted"
  }
}

run "ruleset_rejects_invalid_merge_queue_grouping_strategy" {
  variables {
    name                   = "rulesets-${run.setup.random_string}"
    branch_protection_type = "ruleset"

    branch_rulesets = {
      queue = {
        rules = {
          pull_request = {}

          merge_queue = {
            grouping_strategy = "SOMEGREEN"
          }
        }
      }
    }
  }

  module {
    source = "./"
  }

  command = plan

  expect_failures = [
    var.branch_rulesets,
  ]
}

run "ruleset_rejects_merge_queue_min_entries_above_max" {
  variables {
    name                   = "rulesets-${run.setup.random_string}"
    branch_protection_type = "ruleset"

    branch_rulesets = {
      queue = {
        rules = {
          pull_request = {}

          merge_queue = {
            min_entries_to_merge = 10
          }
        }
      }
    }
  }

  module {
    source = "./"
  }

  command = plan

  expect_failures = [
    var.branch_rulesets,
  ]
}

run "ruleset_rejects_merge_queue_entries_out_of_range" {
  variables {
    name                   = "rulesets-${run.setup.random_string}"
    branch_protection_type = "ruleset"

    branch_rulesets = {
      queue = {
        rules = {
          pull_request = {}

          merge_queue = {
            max_entries_to_build = 101
          }
        }
      }
    }
  }

  module {
    source = "./"
  }

  command = plan

  expect_failures = [
    var.branch_rulesets,
  ]
}

run "ruleset_rejects_merge_queue_timeout_out_of_range" {
  variables {
    name                   = "rulesets-${run.setup.random_string}"
    branch_protection_type = "ruleset"

    branch_rulesets = {
      queue = {
        rules = {
          pull_request = {}

          merge_queue = {
            check_response_timeout_minutes = 0
          }
        }
      }
    }
  }

  module {
    source = "./"
  }

  command = plan

  expect_failures = [
    var.branch_rulesets,
  ]
}

run "ruleset_merge_queue_method_from_merge_strategy" {
  variables {
    name                   = "rulesets-${run.setup.random_string}"
    branch_protection_type = "ruleset"
    merge_strategy         = "squash"

    branch_rulesets = {
      queue = {
        rules = {
          pull_request = {}

          merge_queue = {}
        }
      }
    }
  }

  module {
    source = "./"
  }

  command = plan

  assert {
    condition     = resource.github_repository_ruleset.branches["queue"].rules[0].merge_queue[0].merge_method == "SQUASH"
    error_message = "The merge queue should use the repository's merge_strategy"
  }
}

run "ruleset_merge_queue_method_from_enabled_methods" {
  variables {
    name                   = "rulesets-${run.setup.random_string}"
    branch_protection_type = "ruleset"
    allow_merge_commit     = false

    branch_rulesets = {
      queue = {
        rules = {
          pull_request = {}

          merge_queue = {}
        }
      }
    }
  }

  module {
    source = "./"
  }

  command = plan

  assert {
    condition     = resource.github_repository_ruleset.branches["queue"].rules[0].merge_queue[0].merge_method == "SQUASH"
    error_message = "Without merge_strategy, the merge queue should use the first merge method enabled on the repository"
  }
}

run "ruleset_merge_queue_method_in_allowed_merge_methods" {
  variables {
    name                   = "rulesets-${run.setup.random_string}"
    branch_protection_type = "ruleset"
    merge_strategy         = "squash"

    branch_rulesets = {
      queue = {
        rules = {
          merge_queue  = {}
          pull_request = { allowed_merge_methods = ["squash"] }
        }
      }
    }
  }

  module {
    source = "./"
  }

  command = plan

  assert {
    condition     = resource.github_repository_ruleset.branches["queue"].rules[0].merge_queue[0].merge_method == "SQUASH"
    error_message = "A merge queue whose merge method is in 'allowed_merge_methods' should be accepted"
  }
}

run "ruleset_rejects_merge_queue_method_not_in_allowed_merge_methods" {
  variables {
    name                   = "rulesets-${run.setup.random_string}"
    branch_protection_type = "ruleset"

    branch_rulesets = {
      queue = {
        rules = {
          merge_queue  = {}
          pull_request = { allowed_merge_methods = ["squash"] }
        }
      }
    }
  }

  module {
    source = "./"
  }

  command = plan

  expect_failures = [
    resource.github_repository_ruleset.branches,
  ]
}

run "ruleset_rejects_merge_queue_without_pull_request" {
  variables {
    name                   = "rulesets-${run.setup.random_string}"
    branch_protection_type = "ruleset"

    branch_rulesets = {
      queue = {
        rules = {
          merge_queue = {}
        }
      }
    }
  }

  module {
    source = "./"
  }

  command = plan

  expect_failures = [
    var.branch_rulesets,
  ]
}
