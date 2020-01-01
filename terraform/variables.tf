
variable "packet_auth_token" {}
provider "packet" {

  auth_token = "${ var.packet_auth_token }"
}


variable "node_group_one_project_id" {}
variable "node_group_two_project_id" {}

variable "node_group_one_name" { default = "infra-group-one" }
variable "node_group_two_name" { default = "infra-group-two" }

variable "node_group_one_count" { default = "1" }
variable "node_group_two_count" { default = "1" }

variable "node_group_one_facility" { default = "sjc1" }
variable "node_group_two_facility" { default = "sjc1" }

variable "node_group_one_billing_cycle" { default = "hourly" }
variable "node_group_two_billing_cycle" { default = "hourly" }

variable "node_group_one_device_plan" { default = "m2.xlarge.x86" }
variable "node_group_two_device_plan" { default = "m2.xlarge.x86" }

variable "node_group_one_operating_system" { default = "ubuntu_16_04" }
variable "node_group_two_operating_system" { default = "ubuntu_16_04" }