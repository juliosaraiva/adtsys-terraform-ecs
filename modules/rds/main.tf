resource "aws_db_subnet_group" "main" {
  name       = "${var.prefix}-main"
  subnet_ids = var.private_cidr_blocks

  tags = var.common_tags
}

resource "aws_security_group" "rds" {
  description = "Allow access to the RDS database instance"
  name        = "${var.prefix}-rds-inbound-access"
  vpc_id      = var.vpc_id

  ingress {
    protocol  = "tcp"
    from_port = 5432
    to_port   = 5432
  }

  tags = var.common_tags
}

resource "aws_db_instance" "main" {
  identifier              = "${var.prefix}-db"
  name                    = var.db_name
  allocated_storage       = 20
  storage_type            = "gp2"
  engine                  = "postgres"
  engine_version          = "11.4"
  instance_class          = "db.t2.micro"
  db_subnet_group_name    = aws_db_subnet_group.main.name
  username                = var.db_username
  password                = var.db_password
  backup_retention_period = 0
  multi_az                = false
  skip_final_snapshot     = true
  vpc_security_group_ids  = [aws_security_group.rds.id]

  tags = var.common_tags
}