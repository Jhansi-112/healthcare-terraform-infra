output "environment" {
  value = var.name
}

output "vpc_id" {
  value = module.vpc.vpc_id
}