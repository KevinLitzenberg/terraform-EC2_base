provider "aws" {
    profile    = "east1"
    region     = "us-east-2"
    version    = "~> 2.19" 
}

resource "aws_key_pair" "aws_deploy" {
  key_name = "aws_deploy_key"
  public_key = file("/home/developer/.ssh/aws_deploy.pub")
}

resource "aws_instance" "t2_micro_base" {
    count = var.t2_micro_base_instance_count
    ami = "ami-0891395d749676c2e"
    key_name = aws_key_pair.aws_deploy.key_name
    instance_type = var.t2_micro_base_instance_type
    user_data = templatefile("./templates/t2_micro_base.tf", { hostname = "testingHost${format("%02d", count.index +1)}" })
    tags          = {
      System      = "External Network Testing"
      Component   = "External Network Testing"
      Product     = "Testing Deploys"
      Name        = "Application Server"
      Environment = "Temp"
      Maintainter = "Developer"

    }
 
  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      host        = self.public_ip
      private_key = file("/home/developer/.ssh/aws_deploy")
    }
  }
}

# output "t2_micro_ip_addr" {
#  value       = aws_instance.t2_micro_base[*].public_ip
#  description = "The private IP address of the main server instance."
# }

output "t2_micro_ip_addr" {
  value = { 
    for instance in aws_instance.t2_micro_base:
    instance.id => instance.public_ip
  }

}
