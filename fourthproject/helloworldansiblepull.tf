# Provider Configuration for AWS
provider "aws" {
  region     = "us-east-1"
}
# Resource Configuration for AWS
resource "aws_instance" "myserver" {
  ami = "ami-cfe4b2b0"
  subnet_id = " subnet-02aece0a01a3bdadb"
  instance_type = "t2.micro"
  key_name = "parallelcluster-test"
  vpc_security_group_ids = ["sg-0bf5ffafea3fa6d05"]

  tags ={
    Name = "helloworld"
  }

# Provisioner for applying Ansible playbook in Pull mode
  provisioner "remote-exec" {
    connection {
      user = "ec2-user"
      host = self.public_ip
      private_key = "${file("/root/.ssh/parallelcluster-test.pem")}"
    }
    inline = [
      "sudo yum install --enablerepo=epel -y ansible git",
      "sudo ansible-pull -U https://github.com/taeheilee/ansible helloworld.yml -i localhost",
    ]
  }
  
}

# IP address of newly created EC2 instance
output "myserver" {
 value = "${aws_instance.myserver.public_ip}"
}


