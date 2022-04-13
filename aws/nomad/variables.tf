variable "environment_name" {
  type    = string
  default = "ton_nomad"
}

variable "owner_name" {
  type = string
  default = "ton"
}

variable "aws_region" {
  type    = string
  default = "eu-central-1"
}

variable "nomad_server_count" {
  type    = number
  default = 3
}

variable "nomad_client_count" {
  type    = number
  default = 3
}

variable "lacework_agent_token_name" {
  type    = string
  default = "nomad"
}
