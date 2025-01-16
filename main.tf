provider "aws" {
    region = "us-east-1"  
}

resource "aws_instance" "foo" {
  ami           = "ami-05576a079321f21f8"
  instance_type = "t2.micro"
  tags = {
      Name = "TF-Instance"
  }
}
