terraform {
  backend "s3" {
    bucket                  = "s3-terraform-frank-state"
    key                     = "my-terraform-project"
    region                  = "us-east-1"

  }
}
#hola
#hola

#hola

provider "aws" {}

resource "aws_instance" "frank_instance_public" {
  ami           = "ami-0fc5d935ebf8bc3bc"  # ubuntu AMI
  instance_type = "t2.micro"
  key_name = "frank_keypair" #aws_key_pair.frank_kp.key_name
  subnet_id = aws_subnet.subnet_frank_public.id
  vpc_security_group_ids = [aws_security_group.app_servers_sg.id]
  user_data = <<EOF
#!/bin/bash
sudo apt update
sudo apt install software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install ansible -y
cd ~
mkdir ansible
cd ansible
vi hosts
EOF

  tags = {
    Name = "ansible-controller"
  }
}

resource "aws_instance" "frank_instance_public2" {
  ami           = "ami-0fc5d935ebf8bc3bc"  # ubuntu AMI
  instance_type = "t2.micro"
  key_name = "frank_keypair" #aws_key_pair.frank_kp.key_name
  subnet_id = aws_subnet.subnet_frank_public.id
  vpc_security_group_ids = [aws_security_group.app_servers_sg.id]

  tags = {
    Name = "ansible-agent"
  }
}