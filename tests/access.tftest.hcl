run "setup" {
  module {
    source = "./tests/setup"
  }
}

# Built-in roles are case-insensitive and passed in lowercase.
run "access_built_in_role" {
  variables {
    name = "access-built-in-role-${run.setup.random_string}"
    access = {
      MyTeam = "Maintain"
    }
  }

  module {
    source = "./"
  }

  override_data {
    target = data.github_team.default
    values = {
      id = "123"
    }
  }

  command = plan

  assert {
    condition     = resource.github_team_repository.default["MyTeam"].permission == "maintain"
    error_message = "Built-in role should be passed in lowercase"
  }
}

# Custom repository role names are passed as-is.
run "access_custom_role" {
  variables {
    name = "access-custom-role-${run.setup.random_string}"
    access = {
      MyTeam = "Maintain-Secret-Scanning"
    }
  }

  module {
    source = "./"
  }

  override_data {
    target = data.github_team.default
    values = {
      id = "123"
    }
  }

  command = plan

  assert {
    condition     = resource.github_team_repository.default["MyTeam"].permission == "Maintain-Secret-Scanning"
    error_message = "Custom role name should be passed as-is"
  }
}

run "access_rejects_empty_role" {
  variables {
    name = "access-rejects-empty-role-${run.setup.random_string}"
    access = {
      MyTeam = " "
    }
  }

  module {
    source = "./"
  }

  command = plan

  expect_failures = [var.access]
}

run "access_rejects_surrounding_whitespace" {
  variables {
    name = "access-rejects-surrounding-whitespace-${run.setup.random_string}"
    access = {
      MyTeam = " maintain-secret-scanning"
    }
  }

  module {
    source = "./"
  }

  command = plan

  expect_failures = [var.access]
}

