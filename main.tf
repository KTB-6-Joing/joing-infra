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
  source = "./modules/eks"
}

/*
module "eks" {
  source = "./modules/ecr"
}
*/