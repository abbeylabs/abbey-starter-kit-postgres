terraform {
  required_providers {
    abbey = {
      source = "abbeylabs/abbey"
      version = "~> 0.2.6"
    }
    postgresql = {
      source = "cyrilgdn/postgresql"
      version = "~> 1.19.0"
    }
  }
}
