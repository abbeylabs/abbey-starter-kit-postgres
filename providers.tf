provider "abbey" {
  bearer_auth = var.abbey_token
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
