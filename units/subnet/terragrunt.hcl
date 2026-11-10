terraform {
  source = "../../../modules/subnet"
}

remote_state {
  backend = "local"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    path = "${get_env("STATE_DIR", "/tmp/mock-stack-state")}/subnet.tfstate"
  }
}

dependency "vpc" {
  config_path = "../vpc"

  # Mock shaped like the real vpc output: default.singleton.{id,arn,tags}
  mock_outputs = {
    default = {
      singleton = {
        id   = "mock-vpc-id-12345"
        arn  = "arn:aws:ec2:us-east-1:123456789012:vpc/vpc-0123456789abcdef0"
        tags = { Name = "mock-vpc12345" }
      }
    }
  }
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"]
}

inputs = {
  vpc_id = dependency.vpc.outputs.default.singleton.id
}
