module "vpc" {
  source = "./modules/vpc"
}

module "subnet" {
  source = "./modules/subnet"

  vpc_id     = module.vpc.vpc_id
  igw_rtb_id = module.vpc.igw_rtb_id
}

module "ec2" {
  source = "./modules/ec2"

  vpc_id        = module.vpc.vpc_id
  public_subnet = module.subnet.ec2_public
}

module "eks" {
  source                = "./modules/eks"
  vpc_id                = module.vpc.vpc_id
  cluster_subnet_ids    = module.subnet.eks_cluster
  node_group_subnet_ids = module.subnet.node_group_subnet_ids
}

module "ecr" {
  source = "./modules/ecr"
}

module "rds" {
  source             = "./modules/rds"
  vpc_id             = module.vpc.vpc_id
  db_master_username = var.db_master_username
  db_master_password = var.db_master_password
  subnet_group_name  = module.subnet.mysql_subnet_group_name
}