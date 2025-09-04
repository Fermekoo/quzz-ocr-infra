provider "aws" {
  region = var.aws_region
}

data "aws_availability_zones" "available" {}

locals {
  cluster_name = "${var.environment}-${var.cluster_base_name}"
  node_conf = var.node_config[var.environment]
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "6.0.1"

  name = "${local.cluster_name}-vpc"
  cidr = var.vpc_cidr

  azs = var.availability_zones

  private_subnets = var.private_subnets
  public_subnets = var.public_subnets

  enable_nat_gateway = true
  single_nat_gateway = true

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb" = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb" = "1"
  }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  name               = local.cluster_name     
  kubernetes_version = "1.33"

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  eks_managed_node_groups = {
    main = {
      min_size       = local.node_conf.min_size
      max_size       = local.node_conf.max_size
      desired_size   = local.node_conf.desired_size
      instance_types = local.node_conf.instance_types
    }
  }

  depends_on = [module.vpc]
}


