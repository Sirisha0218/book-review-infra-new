resource "aws_db_instance" "mysql" {
  identifier              = "bookreview-db"
  allocated_storage       = 20
  engine                  = "mysql"
  engine_version          = "5.7"
  instance_class          = "db.t3.micro"   # free tier eligible
  username                = var.mysql_admin_username
  password                = var.mysql_admin_password
  db_name                 = var.mysql_database_name
  publicly_accessible     = true
  skip_final_snapshot     = true
  deletion_protection     = false

  # Security group to allow Azure VM access
  vpc_security_group_ids  = [aws_security_group.mysql_sg.id]
}

resource "aws_security_group" "mysql_sg" {
  name        = "mysql-sg"
  description = "Allow MySQL access from Azure backend VM"

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [var.backend_vm_public_ip + "/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
