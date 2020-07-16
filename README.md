Module for bringing up EC2 instances.  

* Default instance number is 3 instances set in var.tf in us-east-2
* Must open up default VPC to accept connection from your local public_ip or 0.0.0.0/0.  Module does not create it's own VPC.
* Must create your own key pair and deal with uploading that to AWS. Key pair is pulled from local.  Point whatever key you want in t2_micro_base_[0S].tf
* Add whatever packages you want preloaded in templates/t2_miro_base.tf
* Output is public IP addresses of instances.
* Rename the .tf file to toggle between Debian9 and Ubuntu16.04.

> terraform init
> terraform plan
> terraform apply
> terraform destroy

Happy Terraforming!
