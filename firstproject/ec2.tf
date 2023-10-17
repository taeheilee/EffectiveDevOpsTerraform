# Provider Configuration for AWS
provider "aws" {
  access_key = "AKIAUPIVS43TQTDZYCE6"
  secret_key = "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"
  region     = "us-east-1"
}
# Resource Configuration for AWS
resource "aws_instance" "myserver" {
  ami = "ami-cfe4b2b0"
  subnet_id = " subnet-02aece0a01a3bdadb"
  instance_type = "t2.micro"
  key_name = "vip3_thlee"
  vpc_security_group_ids = ["sg-0bf5ffafea3fa6d05"]

  tags ={
    Name = "helloworld"
  }
}
