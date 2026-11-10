resource "terraform_data" "vpc" {
  input = "mock-vpc"
}

output "default" {
  value = {
    metadata = { deployed_by = "mock" }
    singleton = {
      id   = "vpc-${terraform_data.vpc.id}"
      arn  = "arn:aws:ec2:us-east-2:000000000000:vpc/${terraform_data.vpc.id}"
      tags = { Name = "real-vpc" }
    }
  }
}
