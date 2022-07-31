variable "privsubnet3_id"{
}
variable "privsubnet4_id"{
}
variable "dbsg_id"{
}

resource "aws_db_subnet_group" "subnetgroup" {
  name       = "subnetgroup"
  subnet_ids = [var.privsubnet3_id, var.privsubnet4_id]
  tags = { Name = "My DB subnet group"}
}

resource "aws_db_instance" "default" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "5.7.31"
  instance_class       = "db.t2.micro"
  db_subnet_group_name = aws_db_subnet_group.subnetgroup.name
  vpc_security_group_ids = [var.dbsg_id]
  db_name               = "mysqldb"
  username             = "joseph"
  password             = "ting1234"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
}
