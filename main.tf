locals {
  account_name = ""
  repo_name = ""

  project_path = "github://${local.account_name}/${local.repo_name}"
  policies_path = "${local.project_path}/policies"
}

resource "abbey_grant_kit" "postgresql_admin" {
  name = "PostgreSQL: Admin"
  description = <<-EOT
    Grants admin role to a user.
    This Grant Kit uses a single-step Grant Workflow that requires only a single reviewer
    from a list of reviewers to approve access.
  EOT

  workflow = {
    steps = [
      {
        reviewers = {
          one_of = ["replace-me@example.com"]
        }
      }
    ]
  }

  policies = [
    { bundle = local.policies_path }
  ]

  output = {
    location = "${local.project_path}/access.tf"
    append = <<-EOT
      resource "postgresql_grant_role" "admin__{{ .user.postgres.role }}" { # {{ .user.email }}
        role       = "{{ .user.postgres.role }}"
        grant_role = "admin"
      }
    EOT
  }
}
