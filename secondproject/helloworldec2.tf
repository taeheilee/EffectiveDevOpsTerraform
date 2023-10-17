# Provider Configuration for AWS
provider "aws" {
  access_key = "AKIAUPIVS43TQTDZYCE6"
  secret_key = "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"
  region     = "us-east-1"
}
# Resource Configuration for AWS
resource "aws_instance" "myserver" {
  ami = "ami-cfe4b2b0"
  instance_type = "t2.micro"
  subnet_id = " subnet-02aece0a01a3bdadb"
  key_name = "parallelcluster-test"
  vpc_security_group_ids = ["sg-0bf5ffafea3fa6d05"]

  tags ={
    Name = "helloworld"
  }

# Helloworld Appication code
  provisioner "remote-exec"{
    connection {
      user = "ec2-user"
      type = "ssh"
      host = self.public_ip
      private_key = "${file("/root/.ssh/parallelcluster-test.pem")}"
    }
    inline = [
      "sudo yum install --enablerepo=epel -y nodejs",
      "sudo wget https://raw.githubusercontent.com/yogeshraheja/Effective-DevOps-with-AWS/master/Chapter02/helloworld.js -O /home/ec2-user/helloworld.js",
      "sudo wget https://raw.githubusercontent.com/yogeshraheja/Effective-DevOps-with-AWS/master/Chapter02/helloworld.conf -O /etc/init/helloworld.conf",
      "sudo start helloworld",
    ]
  }
}
