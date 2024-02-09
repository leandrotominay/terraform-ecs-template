# Region
variable "region" {
  type    = list(string)
  default = ["sa-brazil-1"]
}

# Authentication
variable "access_key" {
  type    = string
  default = "OHXSG9MIIISH0T1HD7IR"
}

variable "secret_key" {
  type    = string
  default = "wRr3nr49nwQGQJNikYjWJROYXjWMjE1ugoGosW9X"
}

variable "project_id" {
  type    = string
  default = "1eb3b5d05ebd451ea420a551ffd5de5e"
}


# availability zones
variable "availability_zones" {
  type    = list(string)
  default = ["sa-brazil-1a"]
}

variable "secgroup_id" {
  description = "ID do grupo de segurança"
    type        = list(string)
  default = ["710b23ac-dd88-4ce1-ba24-eba17134fd48"]

}

