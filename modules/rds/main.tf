resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "${var.db_identifier}-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "${var.db_identifier}-subnet-group"
  }
}

resource "random_password" "db_password" {
  length           = 16
  special          = true
  override_special = "_%"
}

resource "aws_db_instance" "rds_instance" {
  identifier             = var.db_identifier
  allocated_storage      = 20
  engine                 = var.db_engine
  engine_version         = var.db_engine_version
  instance_class         = var.db_instance_class
  username               = var.db_username
  password               = random_password.db_password.result
  db_name                = var.db_name
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids = [var.sg_id]
  skip_final_snapshot    = true
  publicly_accessible    = false
  multi_az               = false

  tags = {
    Name = var.db_identifier
  }
}

#Aqui vamos a almacenar la contraseña generada y ademas le vamos agregar al secret content JSON con otros datos importantes,
    # If I need the password later, I can bring and use from the output. 

resource "aws_secretsmanager_secret" "db_secret" {
  name        = "${var.db_identifier}-credentials"
  description = "Database credentials for ${var.db_identifier}"
}

# Add secret content (JSON)
resource "aws_secretsmanager_secret_version" "db_secret_value" {
  secret_id     = aws_secretsmanager_secret.db_secret.id
  secret_string = jsonencode({
    username = var.db_username
    password = random_password.db_password.result
    engine   = var.db_engine
    host     = aws_db_instance.rds_instance.address
    port     = aws_db_instance.rds_instance.port
    dbname   = var.db_name
  })
}
