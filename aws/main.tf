module "vpc" {

  source = "./modules/vpc"

  name           = "${var.name_prefix}-vodafone-vpc"
  vpc_cidr_range = var.vpc_cidr_range

  tags = {
    Environment  = "dev"
    Project      = "raid9"
    Owner        = "platform-team"
    ManagedBy    = "terraform"
  }
}

module "igw" {

  source = "./modules/igw"

  name    = "${var.name_prefix}-vodafone-vpc"
  vpc_id  = module.vpc.vpc_id

  tags = {
    Environment  = "dev"
    Project      = "raid9"
    Owner        = "platform-team"
    ManagedBy    = "terraform"
  }
}


module "public_subnets" {
 
  source = "./modules/subnets"
  vpc_id  = module.vpc.vpc_id
  name    = "${var.name_prefix}-vodafone-subnet"
  public_subnets = [
    var.public_subnet_cidr_a,
    var.public_subnet_cidr_b,
    var.public_subnet_cidr_c
  ]
  azs = var.azs
  map_public_ip_on_launch = true

  tags = {
    Environment  = "dev"
    Project      = "raid9"
    Owner        = "platform-team"
    ManagedBy    = "terraform"
  }
}
 
module "private_subnets" {

  source = "./modules/subnets"
  vpc_id  = module.vpc.vpc_id
  name    = "${var.name_prefix}-vodafone-subnet"
  private_subnets = [
    var.private_subnet_cidr_a,
    var.private_subnet_cidr_b,
    var.private_subnet_cidr_c
  ]
  azs = var.azs
  map_public_ip_on_launch = false

  tags = {
    Environment  = "dev"
    Project      = "raid9"
    Owner        = "platform-team"
    ManagedBy    = "terraform"
  }
}

module "database_subnets" {

  source = "./modules/subnets"
  vpc_id  = module.vpc.vpc_id
  name    = "${var.name_prefix}-vodafone-subnet"
  database_subnets = var.db_create ? compact([
    var.database_subnet_cidr_a,
    var.database_subnet_cidr_b
  ]) : []

  azs = var.azs
  map_public_ip_on_launch = false

  tags = {
    Environment  = "dev"
    Project      = "raid9"
    Owner        = "platform-team"
    ManagedBy    = "terraform"
  }
}

module "nat_gateway" {

  source = "./modules/nat"

  name = "${var.name_prefix}-vodafone"

  enable_nat_gateway = true

  public_subnet_ids = module.public_subnets.public_subnet_ids

  tags = {
    Environment = "dev"
    Project     = "raid9"
    Owner       = "platform-team"
    ManagedBy   = "terraform"
  }
}


module "route_table" {

  source = "./modules/route_table"

  vpc_id  = module.vpc.vpc_id
  name    = "${var.name_prefix}-vodafone"
  internet_gateway_id = module.igw.internet_gateway_id

  enable_nat_gateway = true

  public_subnet_ids = module.public_subnets.public_subnet_ids

  tags = {
    Environment = "dev"
    Project     = "raid9"
    Owner       = "platform-team"
    ManagedBy   = "terraform"
  }
}

module "public_route_association" {

  source = "./modules/route_association"

  public_subnet_ids = module.public_subnets.public_subnet_ids

  route_table_id = module.route_table.route_table_id
}


module "private_route_table" {

  source = "./modules/route_table"

  name = "${var.name_prefix}-vodafone"
  
  vpc_id = module.vpc.vpc_id
  internet_gateway_id = module.igw.internet_gateway_id
  enable_nat_gateway = true

  nat_gateway_id = module.nat_gateway.nat_gateway_id

  tags = {
    Environment = "dev"
    Project     = "raid9"
    Owner       = "platform-team"
    ManagedBy   = "terraform"
  }
}


module "private_route_association" {

  source = "./modules/route_association"

  private_subnet_ids = module.private_subnets.private_subnet_ids

  route_table_id = module.route_table.route_table_id


}

