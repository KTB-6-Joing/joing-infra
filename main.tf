// 모듈 폴더 선언만 존재하게 작성

module "vpc" {
  source = "./modules/vpc"
}

module "subnet" {
  source = "./modules/subnet"

  vpc_id     = module.vpc.vpc_id
  igw_rtb_id = module.vpc.igw_rtb_id
}

module "eks" {
  source                = "./modules/eks"
  vpc_id                = module.vpc.vpc_id
  cluster_subnet_ids    = module.subnet.eks_cluster
  node_group_subnet_ids = module.subnet.eks_node_group
}

module "ecr" {
  source = "./modules/ecr"
}

module "rds" {
  source            = "./modules/rds"
  vpc_id            = module.vpc.vpc_id
  subnet_group_name = module.subnet.mysql_subnet_group_name
}