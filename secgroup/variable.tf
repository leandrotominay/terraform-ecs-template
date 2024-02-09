variable "security_groups" {
  description = "List of security groups to be created"
  type = list(object({
    name            = string
    description     = string
    inbound_rules   = list(object({
      protocol        = string
      port_range_min  = number
      port_range_max  = number
      remote_ip_prefix = string
    }))
    outbound_rules  = list(object({
      protocol        = string
      port_range_min  = number
      port_range_max  = number
      remote_ip_prefix = string
    }))
  }))
}
