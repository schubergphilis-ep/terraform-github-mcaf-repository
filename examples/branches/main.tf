// This example to create and manage an additional branch called `develop`
module "basic" {
  #checkov:skip=CKV_GIT_4:Ensure GitHub Actions secrets are encrypted - n/a for the example

  source = "../.."

  name = "basic"

  branches = {
    develop = {}
  }
}

// It's not needed to specify the default branch name as it's already merged in by the module, but for completeness and for testing purposes, it's shown here
module "with_default_branch" {
  #checkov:skip=CKV_GIT_4:Ensure GitHub Actions secrets are encrypted - n/a for the example

  source = "../.."

  name = "basic"

  branches = {
    develop = {}
    main    = {}
  }
}

// This example updates the default branch protection settings which should be applied to all branches
module "with_updated_default_branch_protection" {
  #checkov:skip=CKV_GIT_4:Ensure GitHub Actions secrets are encrypted - n/a for the example

  source = "../.."

  name = "basic"

  branches = {
    develop = {}
  }

  default_branch_protection = {
    enforce_admins         = true
    require_signed_commits = true
  }
}

// This example creates a branch with custom branch protection settings
module "with_custom_branch_protection" {
  #checkov:skip=CKV_GIT_4:Ensure GitHub Actions secrets are encrypted - n/a for the example

  source = "../.."

  name = "basic"

  branches = {
    develop = {
      // if this is set, it takes precedence over the default branch protection settings
      branch_protection = {
        enforce_admins         = true
        require_signed_commits = true
      }
    }
  }
}

// This example creates a branch without any branch protection
module "with_no_branch_protection" {
  #checkov:skip=CKV_GIT_4:Ensure GitHub Actions secrets are encrypted - n/a for the example

  source = "../.."

  name = "basic"

  branches = {
    develop = {
      use_branch_protection = false
    }
  }
}

// This example protects the default branch with the default ruleset instead of classic branch protection
module "with_default_ruleset" {
  #checkov:skip=CKV_GIT_4:Ensure GitHub Actions secrets are encrypted - n/a for the example

  source = "../.."

  name                   = "basic"
  branch_protection_type = "ruleset"
}

// This example creates a custom ruleset for the default and release branches
module "with_custom_rulesets" {
  #checkov:skip=CKV_GIT_4:Ensure GitHub Actions secrets are encrypted - n/a for the example

  source = "../.."

  name                   = "basic"
  branch_protection_type = "ruleset"

  branch_rulesets = {
    protected = {
      bypass_actors = [
        { actor_type = "OrganizationAdmin", bypass_mode = "pull_request" },
      ]

      conditions = {
        ref_name = { include = ["~DEFAULT_BRANCH", "refs/heads/release/**"] }
      }

      rules = {
        pull_request = { required_approving_review_count = 1 }

        required_status_checks = {
          required_checks = [{ context = "test" }]
        }
      }
    }
  }
}
