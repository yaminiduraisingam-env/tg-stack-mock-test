terraform {
  source = "../../../modules/vpc"
}

remote_state {
  backend = "local"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    path = "${get_env("STATE_DIR", "/tmp/mock-stack-state")}/vpc.tfstate"
  }
}
