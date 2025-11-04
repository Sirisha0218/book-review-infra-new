output "frontend_public_ip" {
  value = module.compute.frontend_public_ip
}

output "backend_public_ip" {
  value = module.compute.backend_public_ip
}

output "public_subnet_id" {
  value = module.network.public_subnet_id
}

output "nsg_id" {
  value = module.network.nsg_id
}

# Updated for AWS RDS
output "mysql_endpoint" {
  value = module.database.mysql_endpoint
}
