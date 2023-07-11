variable "abbey_token" {
  type = string
  sensitive = true
  description = "Abbey API Token"
}

variable "pg_host" {
  type = string
  default = "postgres_server_ip" # CHANGEME
  sensitive = true
}
variable "pg_port" {
  type = number
  default = 5432
  sensitive = true
}
variable "pg_db" {
  type = string
  default = "postgres" # CHANGEME
  sensitive = true
}
variable "pg_username" {
  type = string
  default = "postgres_user" # CHANGEME
  sensitive = true
}
variable "pg_password" {
  type = string
  default = "postgres_password" # CHANGEME
  sensitive = true
}

variable "pg_connect_timeout" {
  type = number
  default = 15
}
