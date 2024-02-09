variable "vpc" {
  type = list(object({
    vpc_name = string
    vpc_cidr = string
    vpc_subnet = list(object({
      sub_name    = string
      sub_cidr    = string
      sub_gateway = string
    }))
  }))
}

variable "region" {
  description = "VPC Region"
  type        = string
}
