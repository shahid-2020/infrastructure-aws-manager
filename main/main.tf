data "aws_availability_zones" "available" {
  state = "available"
}

module "vpc" {
  source = "./modules/vpc"

  cidr_block = local.cidr_block

  tags = {
    Name = "main"
  }
}

module "public_subnets" {
  source = "./modules/subnet"

  vpc_id                = module.vpc.id
  cidr_blocks           = local.public_cidr_blocks
  availability_zones    = data.aws_availability_zones.available.names
  auto_assign_public_ip = true
  name_prefix           = "main"
  tags                  = { Tier : "public" }
}

module "igw" {
  source = "./modules/internet-gateway"

  vpc_id = module.vpc.id

  tags = {
    Name = "main-igw"
  }
}

# module "nat_gateway" {
#   source = "./modules/nat-gateway"

#   subnet_id = module.public_subnets.ids[0]

#   tags = {
#     Name = "main-nat-gateway"
#   }

#   depends_on = [module.igw]
# }

module "public_route_table" {
  source = "./modules/route-table"

  vpc_id         = module.vpc.id
  vpc_cidr_block = module.vpc.cidr_block

  additional_routes = [{ cidr_block = "0.0.0.0/0", gateway_id = module.igw.id }]

  tags = {
    Name = "main-public-route-table"
  }
}

module "public_route_table_subnet_association" {
  source = "./modules/route-table-subnet-association"

  route_table_id = module.public_route_table.id
  subnet_ids     = module.public_subnets.ids
}

module "public_subnet_network_acl" {
  source = "./modules/network-acl"
  count  = length(module.public_subnets.ids)

  vpc_id        = module.vpc.id
  subnet_id     = module.public_subnets.ids[count.index]
  ingress_rules = local.ingress_rules
  egress_rules  = local.egress_rules

  tags = {
    Name = "main-public-subnet-nacl-${count.index + 1}"
  }
}

module "private_subnets" {
  source = "./modules/subnet"

  vpc_id             = module.vpc.id
  cidr_blocks        = local.private_cidr_blocks
  availability_zones = data.aws_availability_zones.available.names
  name_prefix        = "main"
  tags               = { Tier : "private" }
}


module "private_route_table" {
  source = "./modules/route-table"

  vpc_id         = module.vpc.id
  vpc_cidr_block = module.vpc.cidr_block

  # additional_routes = [{
  #   cidr_block = "0.0.0.0/0"
  #   nat_gateway_id = module.nat_gateway.id
  # }]

  tags = {
    Name = "main-private-route-table"
  }
}

module "private_route_table_subnet_association" {
  source = "./modules/route-table-subnet-association"

  route_table_id = module.private_route_table.id
  subnet_ids     = module.private_subnets.ids
}

module "private_subnet_network_acl" {
  source = "./modules/network-acl"
  count  = length(module.private_subnets.ids)

  vpc_id        = module.vpc.id
  subnet_id     = module.private_subnets.ids[count.index]
  ingress_rules = local.ingress_rules
  egress_rules  = local.egress_rules

  tags = {
    Name = "main-private-subnet-nacl-${count.index + 1}"
  }
}

module "db_public_subnet_group" {
  source = "./modules/db-subnet-group"

  name       = "main-public-db-sg"
  subnet_ids = module.public_subnets.ids

  tags = {
    Name = "main-public-db-sg"
  }
}

module "db_private_subnet_group" {
  source = "./modules/db-subnet-group"

  name       = "main-private-db-sg"
  subnet_ids = module.private_subnets.ids

  tags = {
    Name = "main-private-db-sg"
  }
}

module "security_group_egress_all" {
  source = "./modules/security-group"

  name   = "main-egress-all"
  vpc_id = module.vpc.id
}

module "security_group_egress_all_egress" {
  source = "./modules/security-group-egress"

  security_group_id   = module.security_group_egress_all.id
  security_group_name = module.security_group_egress_all.name
  from_port           = -1
  to_port             = -1
  ip_protocol         = "-1"
  cidr_ipv4           = "0.0.0.0/0"
  cidr_ipv6           = "::/0"
}

module "security_group_ssh" {
  source = "./modules/security-group"

  name   = "main-ssh"
  vpc_id = module.vpc.id
}

module "security_group_ssh_ingress" {
  source = "./modules/security-group-ingress"

  security_group_id   = module.security_group_ssh.id
  security_group_name = module.security_group_ssh.name
  from_port           = 22
  to_port             = 22
  ip_protocol         = "TCP"
  cidr_ipv4           = "0.0.0.0/0"
  cidr_ipv6           = "::/0"
}

module "security_group_http" {
  source = "./modules/security-group"

  name   = "main-http"
  vpc_id = module.vpc.id
}

module "security_group_http_ingress" {
  source = "./modules/security-group-ingress"

  security_group_id   = module.security_group_http.id
  security_group_name = module.security_group_http.name
  from_port           = 80
  to_port             = 80
  ip_protocol         = "TCP"
  cidr_ipv4           = "0.0.0.0/0"
  cidr_ipv6           = "::/0"
}

module "security_group_https" {
  source = "./modules/security-group"

  name   = "main-https"
  vpc_id = module.vpc.id
}

module "security_group_https_ingress" {
  source = "./modules/security-group-ingress"

  security_group_id   = module.security_group_https.id
  security_group_name = module.security_group_https.name
  from_port           = 443
  to_port             = 443
  ip_protocol         = "TCP"
  cidr_ipv4           = "0.0.0.0/0"
  cidr_ipv6           = "::/0"
}

module "security_group_ingress_3000" {
  source = "./modules/security-group"

  name   = "main-ingress-3000"
  vpc_id = module.vpc.id
}

module "security_group_ingress_3000_ingress" {
  source = "./modules/security-group-ingress"

  security_group_id   = module.security_group_ingress_3000.id
  security_group_name = module.security_group_ingress_3000.name
  from_port           = 3000
  to_port             = 3000
  ip_protocol         = "TCP"
  cidr_ipv4           = "0.0.0.0/0"
  cidr_ipv6           = "::/0"
}

module "security_group_ingress_5432" {
  source = "./modules/security-group"

  name   = "main-ingress-5432"
  vpc_id = module.vpc.id
}

module "security_group_ingress_5432_ingress" {
  source = "./modules/security-group-ingress"

  security_group_id   = module.security_group_ingress_5432.id
  security_group_name = module.security_group_ingress_5432.name
  from_port           = 5432
  to_port             = 5432
  ip_protocol         = "TCP"
  cidr_ipv4           = "0.0.0.0/0"
  cidr_ipv6           = "::/0"
}

module "ecs_cluster_staging" {
  source = "./modules/ecs-cluster"

  name = "staging"
}

module "ecs_cluster_production" {
  source = "./modules/ecs-cluster"

  name = "production"
}

module "terraform_backend" {
  source = "./modules/s3"

  name = "terraform-common-backend"
}