variable "aws_region" {
  description = "Region for quzz infrastructure"
  type = string
  default = "ap-southeast-1"
}

variable "environment" {
    description= "deployment environment. use 'd' for development or 'p' for production"
    type = string

    validation{
        condition = contains(["d","p"], var.environment)
        error_message = "environment value must be 'd' atau 'p'"
    }
}

variable "cluster_base_name" {
  description = "base name for EKS cluster (without env prefix)"
  type = string
  default = "quzz-ocr-app"
}

variable "availability_zones" {
  description = "Daftar Availability Zone yang akan digunakan."
  type        = list(string)
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type = string
  default = "10.0.0.0/16"
}

variable "private_subnets" {
  description = "CIDR block for public subnet"
  type = list(string)
}

variable "public_subnets" {
  description = "CIDR for public subnets"
  type = list(string)
}

variable "node_config" {
  description = "worker nodes configuration for each environment"
  type = map(object({
    instance_types = list(string)
    min_size = number
    max_size = number
    desired_size = number
  }))

  default = {
    "d" = {
      instance_types = ["t3.medium"]
      min_size = 1
      max_size = 3
      desired_size = 1
    },
    "p" = {
        instance_types = ["m5.large"]
        min_size = 2
        max_size = 5
        desired_size = 2
    }
  }
}



