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
    condition     = length(resource.github_branch.default) == 2
    error_message = "Branches should still be created in ruleset mode"
  }

  assert {
    condition     = keys(resource.github_repository_ruleset.branches) == ["default-branch"]
    error_message = "Only the default ruleset should be created"
  }

  assert {
    condition     = resource.github_repository_ruleset.branches["default-branch"].conditions[0].ref_name[0].include == tolist(["~DEFAULT_BRANCH"])
    error_message = "Default ruleset should target the default branch"
  }

  assert {
    condition     = length(resource.github_repository_ruleset.branches["default-branch"].bypass_actors) == 0
    error_message = "Default ruleset should have no bypass actors"
  }

  assert {
    condition = (
      resource.github_repository_ruleset.branches["default-branch"].rules[0].deletion == true &&
      resource.github_repository_ruleset.branches["default-branch"].rules[0].non_fast_forward == true &&
      resource.github_repository_ruleset.branches["default-branch"].rules[0].required_signatures == true
    )
    error_message = "Default ruleset should block deletion and force pushes and require signatures"
  }

  assert {
    condition     = resource.github_repository_ruleset.branches["default-branch"].rules[0].pull_request[0].required_approving_review_count == 2
    error_message = "Default required_approving_review_count does not match"
  }

  assert {
    condition = (
      resource.github_repository_ruleset.branches["default-branch"].rules[0].pull_request[0].require_code_owner_review == true &&
      resource.github_repository_ruleset.branches["default-branch"].rules[0].pull_request[0].dismiss_stale_reviews_on_push == true
    )
    error_message = "Default code owner and stale review settings do not match"
  }

  assert {
    condition     = length(resource.github_repository_ruleset.branches["default-branch"].rules[0].required_status_checks) == 0
    error_message = "No status checks should be required by default"
  }
}

run "ruleset_custom" {
  variables {
    name                   = "rulesets-${run.setup.random_string}"
    branch_protection_type = "ruleset"

    branch_rulesets = {
      protected = {
        bypass_actors = [
          { actor_type = "OrganizationAdmin", bypass_mode = "pull_request" },
          { actor_id = 5, actor_type = "RepositoryRole", bypass_mode = "pull_request" },
        ]

        conditions = {
          ref_name = {
            include = ["~DEFAULT_BRANCH", "refs/heads/release/**"]
            exclude = ["refs/heads/release/old"]
          }
        }

        rules = {
          required_signatures = false

          pull_request = {
            required_approving_review_count = 1
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
    }
  }

  module {
    source = "./"
  }

  command = plan

  assert {
    condition     = keys(resource.github_repository_ruleset.branches) == ["protected"]
    error_message = "Custom rulesets should replace the default"
  }

  assert {
    condition     = resource.github_repository_ruleset.branches["protected"].conditions[0].ref_name[0].exclude == tolist(["refs/heads/release/old"])
    error_message = "Ruleset exclude does not match"
  }

  assert {
    condition     = length(resource.github_repository_ruleset.branches["protected"].bypass_actors) == 2
    error_message = "Bypass actors do not match"
  }

  assert {
    condition     = resource.github_repository_ruleset.branches["protected"].rules[0].required_signatures == false
    error_message = "required_signatures does not match"
  }

  assert {
    condition     = resource.github_repository_ruleset.branches["protected"].rules[0].non_fast_forward == true
    error_message = "Force pushes should be blocked unless disabled"
  }

  assert {
    condition     = resource.github_repository_ruleset.branches["protected"].rules[0].pull_request[0].required_approving_review_count == 1
    error_message = "required_approving_review_count does not match"
  }

  assert {
    condition     = resource.github_repository_ruleset.branches["protected"].rules[0].required_status_checks[0].strict_required_status_checks_policy == true
    error_message = "strict_required_status_checks_policy does not match"
  }

  assert {
    condition     = length(resource.github_repository_ruleset.branches["protected"].rules[0].required_status_checks[0].required_check) == 2
    error_message = "Required checks do not match"
  }

  assert {
    condition     = length(resource.github_repository_ruleset.branches["protected"].rules[0].required_deployments) == 0
    error_message = "No required deployments should be set"
  }
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
