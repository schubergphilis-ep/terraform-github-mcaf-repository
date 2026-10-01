run "setup" {
  module {
    source = "./tests/setup"
  }
}

# Push protection is enabled by default when Secret Protection is enabled.
run "secret_protection_enabled" {
  variables {
    name = "secret-protection-enabled-${run.setup.random_string}"
    secret_protection = {
      enabled = true
    }
  }

  module {
    source = "./"
  }

  command = plan

  assert {
    condition     = resource.github_repository.default.security_and_analysis[0].secret_scanning[0].status == "enabled"
    error_message = "Secret scanning should be enabled"
  }

  assert {
    condition     = resource.github_repository.default.security_and_analysis[0].secret_scanning_push_protection[0].status == "enabled"
    error_message = "Push protection should be enabled"
  }

  assert {
    condition     = length(resource.github_repository.default.security_and_analysis[0].advanced_security) == 0
    error_message = "Advanced security should not be configured"
  }

  assert {
    condition     = length(resource.github_repository.default.security_and_analysis[0].code_security) == 0
    error_message = "Code security should not be configured"
  }
}

run "secret_protection_without_push_protection" {
  variables {
    name = "secret-protection-without-push-protection-${run.setup.random_string}"
    secret_protection = {
      enabled         = true
      push_protection = false
    }
  }

  module {
    source = "./"
  }

  command = plan

  assert {
    condition     = resource.github_repository.default.security_and_analysis[0].secret_scanning[0].status == "enabled"
    error_message = "Secret scanning should be enabled"
  }

  assert {
    condition     = resource.github_repository.default.security_and_analysis[0].secret_scanning_push_protection[0].status == "disabled"
    error_message = "Push protection should be disabled"
  }
}

# Push protection cannot be enabled without secret scanning, so disabling Secret Protection disables both.
run "secret_protection_disabled" {
  variables {
    name = "secret-protection-disabled-${run.setup.random_string}"
    secret_protection = {
      enabled         = false
      push_protection = true
    }
  }

  module {
    source = "./"
  }

  command = plan

  assert {
    condition     = resource.github_repository.default.security_and_analysis[0].secret_scanning[0].status == "disabled"
    error_message = "Secret scanning should be disabled"
  }

  assert {
    condition     = resource.github_repository.default.security_and_analysis[0].secret_scanning_push_protection[0].status == "disabled"
    error_message = "Push protection should be disabled"
  }
}
