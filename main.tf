terraform {
  backend "http" {
    address        = "https://api.abbey.io/terraform-http-backend"
    lock_address   = "https://api.abbey.io/terraform-http-backend/lock"
    unlock_address = "https://api.abbey.io/terraform-http-backend/unlock"
    lock_method    = "POST"
    unlock_method  = "POST"
  }

  required_providers {
    abbey = {
      source = "abbeylabs/abbey"
      version = "0.1.4"
    }
    postgresql = {
      source = "cyrilgdn/postgresql"
      version = "1.19.0"
    }
  }
}

provider "abbey" {
  # Configuration options
}

provider "postgresql" {
  host            = var.pg_host
  port            = var.pg_port
  database        = var.pg_db
  username        = var.pg_username
  password        = var.pg_password
  sslmode         = "require"
  connect_timeout = var.pg_connect_timeout
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
          # Typically uses your Primary Identity.
          # For this local example, you can pass in an arbitrary string.
          # For more information on what a Primary Identity is, visit https://docs.abbey.io.
          one_of = ["replace-me@example.com"]
        }
      }
    ]
  }

  output = {
    # Replace with your own path pointing to where you want your access changes to manifest.
    # Path is an RFC 3986 URI, such as `github://{organization}/{repo}/path/to/file.tf`.
    location = "github://replace-me-with-organization/replace-me-with-repo/access.tf" # CHANGEME
    append = <<-EOT
      resource "postgresql_grant_role" "admin__{{ .data.system.abbey.secondary_identities.postgresql.role }}" { # {{ .data.system.abbey.abbey_identity }}
        role       = "{{ .data.system.abbey.secondary_identities.postgresql.role }}"
        grant_role = "admin"
      }
    EOT
  }
}

resource "abbey_identity" "user_1" {
  name = "User 1" # CHANGEME

  linked = jsonencode({
    abbey = [
      {
        type  = "AuthId"
        value = "replace-me@example.com"
      }
    ]

    postgresql = [
      {
        role = "testuser"
      }
    ]
  })
}
