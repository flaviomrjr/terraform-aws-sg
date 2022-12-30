resource "aws_security_group" "allow_tls" {
  for_each = {
    for sg in local.sgs : sg.name => sg
  }
  
  name        = each.value.name
  description = each.value.description
  vpc_id      = each.value.vpc_id

  dynamic "ingress" {
    for_each = [
      for ingress in local.security_group_ingress : ingress
      if ingress.key == each.value.name
    ]

    content {
      description = ingress.value.description
      from_port = ingress.value.from_port
      to_port = ingress.value.to_port
      protocol = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
      security_groups = ingress.value.security_groups
    }
  }

  dynamic "egress" {
    for_each = [
      for egress in local.security_group_egress : egress
      if egress.key == each.value.name
    ]
    content {
      description = egress.value.description
      from_port = egress.value.from_port
      to_port = egress.value.to_port
      protocol = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
      security_groups = egress.value.security_groups
    }
  }

  tags = each.value.spec.tags
}