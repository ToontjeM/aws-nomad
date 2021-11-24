variable "environment_name" {
  type    = string
  default = "docker"
}

variable "owner_name" {
  type = string
}

variable "aws_region" {
  type    = string
  default = "eu-central-1"
}

variable "docker_server_count" {
  type    = number
  default = 3
}

variable "lacework_agent_token_name" {
  type    = string
  default = "docker"
}

variable "profile" {
  type = string
}
