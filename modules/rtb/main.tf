variable "vpc_id" {
  type = string
}

resource "terraform_data" "rtb" {
  input = var.vpc_id
}

output "default" {
  value = { vpc_id = terraform_data.rtb.input }
}
