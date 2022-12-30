Terraform AWS Security Groups with yaml files
======================================

This project creates AWS Security Groups with yaml files as data input

# GET STARTED

You have to create a yaml file inside the folder `sgs.d`

You can create as many files as you want!

Check this example yaml file:

```yaml
name: SG-eks-1
description: SG EKS
vpc_id: vpc-000000
spec:
  security_group_ingress:
  - protocol: tcp
    from_port: 22
    to_port: 22
    cidr_blocks: [10.10.0.0/24]
    description: From CIDR EKS
  - protocol: tcp
    from_port: 22
    to_port: 22
    security_groups: ["sg-000000000"]
    description: From SG EKS
  security_group_egress: 
  - protocol: tcp
    from_port: 0
    to_port: 0
    cidr_blocks: [0.0.0.0/0]
    description: Default Outbound EKS
  tags:
    env: dev
    resource: eks
```

Look that you can specify or not `cidr_blocks` and `security_groups`

**note:** In case you want to add more attributes in the yaml file like `ipv6_cidr_blocks`, you will need to modify this project

## DEPLOY

Terraform will check the yaml files at `sgs.d` folder and create them

execute:
```shell
$ terraform plan

$ terraform apply
```


Enjoy

By Flavio Rocha