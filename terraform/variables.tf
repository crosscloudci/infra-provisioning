provider "packet" {

  auth_token = "${ var.packet_api_key }"
}

variable "name" {}
variable "packet_api_key" {}
variable "packet_project_id" {}

variable "packet_master_node_count" { default = "1" }
variable "packet_worker_node_count" { default = "1" }
variable "packet_facility" { default = "sjc1" }
variable "packet_billing_cycle" { default = "hourly" }

variable "packet_master_device_plan" { default = "m2.xlarge.x86" }
variable "packet_worker_device_plan" { default = "m2.xlarge.x86" }
variable "packet_operating_system" { default = "ubuntu_16_04" }