locals {
  flat_vpc = flatten([
    for a, b in var.vpc : [
      for c in b.vpc_subnet : {
        name        = b.vpc_name
        cidr        = b.vpc_cidr
        sub_name    = c.sub_name
        sub_cidr    = c.sub_cidr
        sub_gateway = c.sub_gateway
      }
    ]
  ])
}

# Criacao das VPCs 

resource "huaweicloud_vpc" "custom" {
  for_each = { for k in local.flat_vpc : k.name => k.cidr... }
  name     = each.key
  cidr     = each.value[0]
  region   = var.region
  #    enterprise_project_id   = var.enterprise
}

# Mapeamento das IDs das VPCs

locals {
  vpc_id_map = {
    for vpc in huaweicloud_vpc.custom : vpc.name => vpc.id
  }
}

# Criacao das Subnets 

resource "huaweicloud_vpc_subnet" "custom" {
  for_each = { for i, v in local.flat_vpc : v.sub_name => v }
  name     = each.value.sub_name
  cidr     = each.value.sub_cidr

  gateway_ip = each.value.sub_gateway
  vpc_id     = huaweicloud_vpc.custom[each.value.name].id
}

# Mapeamento das subnets ids

locals {
  sub_id_map = {
    for sub in huaweicloud_vpc_subnet.custom : sub.name => sub.id
  }
}