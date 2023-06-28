# Abbey Starter Kit Quickstart Example

This example shows how to create a single step Grant Kit workflow.
The example features requesting access to a [postgresql](https://registry.terraform.io/providers/cyrilgdn/postgresql/latest/docs) admin role from multiple reviewers, requiring only `one_of` the reviewers to approve the access.

## Usage

Visit this [Starter Kit's docs](https://docs.abbey.io/getting-started/quickstart) for a short usage walkthrough.

- Let's say you have a database named `postgres` and an `admin` role that you'd like to assign to engineers who are on-call.
- Engineers on call can request access to be assigned the `admin` role via Abbey. This will create a PR appending the following snippet to `access.tf`:
  ```hcl
  resource "postgresql_grant_role" "admin__testuser" { # replace-me@example.com
    role       = "testuser"
    grant_role = "admin"
  }
  ```
- Once approved, the user will be granted the `admin` role.
- When the access is revoked, the `admin` role will be revoked from the user.

## :books: Learn More

To learn more about Grant Kits and Grant Workflows, visit the following resources:

-   [Abbey Labs Documentation](https://docs.abbey.io) - learn about automating access management with Abbey Labs.
