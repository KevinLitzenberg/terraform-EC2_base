locals {
  common_tags = {
    "Creator"     = "Developer"
    "Environment" = "Staging"
    "Product"     = "Testing Deploys"
  }
}

variable "t2_micro_base_instance_count" {
    description = "How many t2_micro instances to create"
    default = 3
}

variable "t2_micro_base_instance_type" {
    description = "Instance type of base install"
    default = "t2.micro"
}
