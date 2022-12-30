locals {
  sgs = [for _, value in fileset("./sgs.d", "*.yaml") : yamldecode(file("./sgs.d/${value}"))]

  security_group_ingress = flatten([
    for _, sgFile in local.sgs : [   
        for _, ingress in sgFile.spec.security_group_ingress : {
            key = sgFile.name
            description = ingress.description
            from_port = ingress.from_port
            to_port = ingress.to_port
            protocol = ingress.protocol
            cidr_blocks = try(ingress.cidr_blocks, null)
            security_groups = try(ingress.security_groups, [])
        }
    ]
  ])

  security_group_egress = flatten([
    for _, sgFile in local.sgs : [
      for _, egress in sgFile.spec.security_group_egress : {
        key = sgFile.name
        description = egress.description
        from_port = egress.from_port
        to_port = egress.to_port
        protocol = egress.protocol
        cidr_blocks = try(egress.cidr_blocks, null)
        security_groups = try(egress.security_groups, [])
      }
    ]
  ])
}