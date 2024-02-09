variable "secgroup_id" {
  description = "Security group ID"
  type        = string
}

variable "ecs_instances" {
  description = "Lista de instâncias ECS"
  type        = list(object({
    instance_name     = string
    image_id          = string
    flavor_id         = string
    # key_pair          = string
    availability_zone = string
    
    network_uuid      = list(object({
      uuid = string
    }))
  }))
}
