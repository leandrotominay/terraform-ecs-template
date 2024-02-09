locals {
  inbound_rules = flatten([
    for sg in var.security_groups : [
      for inbound_rule in sg.inbound_rules : {
        sg_name           = sg.name
        sg_description    = sg.description
        direction         = "ingress"
        protocol          = inbound_rule.protocol
        port_range_min    = inbound_rule.port_range_min
        port_range_max    = inbound_rule.port_range_max
        remote_ip_prefix  = inbound_rule.remote_ip_prefix
      }
    ]
  ])

  outbound_rules = flatten([
    for sg in var.security_groups : [
      for outbound_rule in sg.outbound_rules : {
        sg_name           = sg.name
        sg_description    = sg.description
        direction         = "egress"
        protocol          = outbound_rule.protocol
        port_range_min    = outbound_rule.port_range_min
        port_range_max    = outbound_rule.port_range_max
        remote_ip_prefix  = outbound_rule.remote_ip_prefix
      }
    ]
  ])

  flat_security_groups = concat(local.inbound_rules, local.outbound_rules)
}

resource "huaweicloud_networking_secgroup" "custom" {
  for_each    = { for sg in var.security_groups : sg.name => sg }
  name        = each.value.name
  description = each.value.description
}

resource "huaweicloud_networking_secgroup_rule" "custom" {
  for_each = { for idx, rule in local.flat_security_groups : idx => rule }
  
  security_group_id = huaweicloud_networking_secgroup.custom[each.value.sg_name].id
  direction         = each.value.direction
  ethertype         = "IPv4"
  protocol          = each.value.protocol
  port_range_min    = each.value.port_range_min
  port_range_max    = each.value.port_range_max
  remote_ip_prefix  = each.value.remote_ip_prefix
}
