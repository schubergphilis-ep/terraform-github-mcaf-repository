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

run "ruleset" {
  variables {
    name                   = "rulesets-${run.setup.random_string}"
    branch_protection_type = "ruleset"

    branch_ruleset_bypass_actors = [
      { actor_type = "OrganizationAdmin", bypass_mode = "pull_request" },
      { actor_id = 5, actor_type = "RepositoryRole", bypass_mode = "pull_request" },
    ]

    branches = {
      develop = {
        branch_protection = {
          require_signed_commits = false

          required_checks = {
            strict   = true
            contexts = ["lint", "test"]
          }

          required_reviews = {
            required_approving_review_count = 1
            require_code_owner_reviews      = false
          }
        }
      }
      feature = {
        use_branch_protection = false
      }
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
    condition     = toset(keys(resource.github_repository_ruleset.branches)) == toset(["develop", "main"])
    error_message = "Rulesets should be created for protected branches only"
  }

  assert {
    condition     = resource.github_repository_ruleset.branches["develop"].conditions[0].ref_name[0].include == tolist(["refs/heads/develop"])
    error_message = "Ruleset ref_name does not match"
  }

  assert {
    condition     = length(resource.github_repository_ruleset.branches["develop"].bypass_actors) == 2
    error_message = "Bypass actors do not match"
  }

  // Custom settings on develop
  assert {
    condition     = resource.github_repository_ruleset.branches["develop"].rules[0].deletion == true && resource.github_repository_ruleset.branches["develop"].rules[0].non_fast_forward == true
    error_message = "Deletion and force push should be blocked"
  }

  assert {
    condition     = resource.github_repository_ruleset.branches["develop"].rules[0].required_signatures == false
    error_message = "required_signatures does not match"
  }

  assert {
    condition     = resource.github_repository_ruleset.branches["develop"].rules[0].pull_request[0].required_approving_review_count == 1
    error_message = "required_approving_review_count does not match"
  }

  assert {
    condition     = resource.github_repository_ruleset.branches["develop"].rules[0].required_status_checks[0].strict_required_status_checks_policy == true
    error_message = "strict_required_status_checks_policy does not match"
  }

  assert {
    condition     = length(resource.github_repository_ruleset.branches["develop"].rules[0].required_status_checks[0].required_check) == 2
    error_message = "Required checks do not match"
  }

  // Default settings on main
  assert {
    condition     = resource.github_repository_ruleset.branches["main"].rules[0].required_signatures == true
    error_message = "Default required_signatures does not match"
  }

  assert {
    condition     = resource.github_repository_ruleset.branches["main"].rules[0].pull_request[0].required_approving_review_count == 2
    error_message = "Default required_approving_review_count does not match"
  }

  assert {
    condition     = resource.github_repository_ruleset.branches["main"].rules[0].pull_request[0].require_code_owner_review == true
    error_message = "Default require_code_owner_review does not match"
  }

  assert {
    condition     = length(resource.github_repository_ruleset.branches["main"].rules[0].required_status_checks) == 0
    error_message = "No status checks should be required by default"
  }
}

run "ruleset_rejects_unsupported_settings" {
  variables {
    name                   = "rulesets-${run.setup.random_string}"
    branch_protection_type = "ruleset"

    default_branch_protection = {
      restrict_pushes = {
        push_allowances = ["my-org/my-team"]
      }
    }
  }

  module {
    source = "./"
  }

  command = plan

  expect_failures = [
    var.branch_protection_type,
  ]
}
