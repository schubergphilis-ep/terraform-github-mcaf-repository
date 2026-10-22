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
      myteam = "Maintain"
    }
  }

  module {
    source = "./"
  }

  command = plan

  assert {
    condition     = resource.github_team_repository.default["myteam"].permission == "maintain"
    error_message = "Built-in role should be passed in lowercase"
  }

  assert {
    condition     = resource.github_team_repository.default["myteam"].team_id == "myteam"
    error_message = "The team slug should be passed as team_id"
  }
}

# Custom repository role names are passed as-is.
run "access_custom_role" {
  variables {
    name = "access-custom-role-${run.setup.random_string}"
    access = {
      myteam = "Maintain-Secret-Scanning"
    }
  }

  module {
    source = "./"
  }

  command = plan

  assert {
    condition     = resource.github_team_repository.default["myteam"].permission == "Maintain-Secret-Scanning"
    error_message = "Custom role name should be passed as-is"
  }
}

run "access_rejects_empty_role" {
  variables {
    name = "access-rejects-empty-role-${run.setup.random_string}"
    access = {
      myteam = " "
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
      myteam = " maintain-secret-scanning"
    }
  }

  module {
    source = "./"
  }

  command = plan

  expect_failures = [var.access]
}

run "access_rejects_team_display_name" {
  variables {
    name = "access-rejects-team-display-name-${run.setup.random_string}"
    access = {
      "My Team" = "maintain"
    }
  }

  module {
    source = "./"
  }

  command = plan

  expect_failures = [var.access]
}

