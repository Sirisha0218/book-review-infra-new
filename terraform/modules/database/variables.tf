variable "mysql_admin_username" {}
variable "mysql_admin_password" {
  sensitive = true
}
variable "mysql_database_name" {}
variable "backend_vm_public_ip" {}
