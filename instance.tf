provider "aws" {
  region  = var.location
  access_key = var.access_key
  secret_key = var.secret_key
}

###############################################################################################################################################

resource "aws_security_group" "web_sg" {
  name = "web_sg"
  description = "Web Server Ports"
  vpc_id = var.vpc_id
  tags = {
    Name = var.tag_name
  }
}

resource "aws_security_group_rule" "web_ingress1" {
    type = "ingress"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [var.ssh_location]
    security_group_id = aws_security_group.web_sg.id
}

resource "aws_security_group_rule" "web_ingress2" {
    type = "ingress"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = aws_security_group.web_sg.id
}

resource "aws_security_group_rule" "web_ingress3" {
    type = "ingress"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = aws_security_group.web_sg.id
}

resource "aws_security_group_rule" "web_egress1" {
    type = "egress"
    protocol = "-1"
    from_port = 0
    to_port = 65535
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = aws_security_group.web_sg.id
}

###############################################################################################################################################

resource "aws_instance" "web_instance" {
    ami = var.ami_id
    instance_type = var.instance_type
    key_name = var.key_name
    subnet_id = var.subnet_id
    vpc_security_group_ids = [aws_security_group.web_sg.id]
    associate_public_ip_address = "true"
    tags = {
        Name = var.tag_name
    }
}

###############################################################################################################################################

output "web_public_ip_addr" {
  value = aws_instance.web_instance.public_ip
}

###############################################################################################################################################

variable "location" {
}

variable "access_key" {
}

variable "secret_key" {
}

variable "ssh_location" {
}

variable "instance_type" {
}

variable "vpc_id" {
}

variable "tag_name" {
}

variable "ami_id" {
}

variable "key_name" {
}

variable "subnet_id" {
}
