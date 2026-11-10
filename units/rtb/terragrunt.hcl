terraform {
  source = "../../../modules/rtb"
}

remote_state {
  backend = "local"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    path = "${get_env("STATE_DIR", "/tmp/mock-stack-state")}/rtb.tfstate"
  }
}

dependency "subnet" {
  config_path = "../subnet"

  mock_outputs = {
    default = { vpc_id = "mock-vpc-id-12345" }
  }
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"]
}

inputs = {
  vpc_id = dependency.subnet.outputs.default.vpc_id
}
