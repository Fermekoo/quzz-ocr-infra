output "cluster_name" {
  description = "EKS cluster name"
  value       = module.eks.cluster_name
}

output "cluster_endpoint" {
  description = "URL API Server Kubernetes."
  value       = module.eks.cluster_endpoint
}

output "cluster_security_group_id" {
  description = "main security group id from EKS cluster"
  value       = module.eks.cluster_security_group_id
}

output "configure_kubectl" {
  description = "Run this command to configure kubectl to connect to your EKS cluster."
  value       = "aws eks --region ${var.aws_region} update-kubeconfig --name ${module.eks.cluster_name}"
}