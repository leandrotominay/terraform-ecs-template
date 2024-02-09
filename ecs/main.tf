locals {
  ecs_instances_flat = [
    for instance in var.ecs_instances : {
      instance_name     = instance.instance_name
      image_id          = instance.image_id
      flavor_id         = instance.flavor_id
    #   key_pair          = instance.key_pair
      availability_zone = instance.availability_zone
      network_uuid      = instance.network_uuid
    }
  ]
}

resource "huaweicloud_compute_instance" "ecs_instance" {
  for_each = { for k, v in local.ecs_instances_flat : k => v }
  
  name            = each.value.instance_name
  image_id        = each.value.image_id
  flavor_id       = each.value.flavor_id
#   key_pair        = each.value.key_pair
  security_group_ids = [var.secgroup_id]
  availability_zone = each.value.availability_zone
  
  dynamic "network" {
    for_each = each.value.network_uuid
    content {
      uuid = network.value.uuid
    }
  }
}
