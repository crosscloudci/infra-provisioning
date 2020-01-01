resource "packet_device" "node_group_one" {
  project_id       = "${ var.node_group_one_project_id }"
  hostname         = "${ var.node_group_one_name }${ count.index + 1 }"
  count            = "${ var.node_group_one_count }"
  facilities       = ["${ var.node_group_one_facility }"]
  plan             = "${ var.node_group_one_device_plan }" # Packet.net machine type
  billing_cycle    = "${ var.node_group_one_billing_cycle }" # hourly or monthly
  operating_system = "${ var.node_group_one_operating_system }"
 
}

resource "packet_device" "node_group_two" {
  project_id       = "${ var.node_group_two_project_id }"
  hostname         = "${ var.node_group_two_name }${ count.index + 1 }"
  count            = "${ var.node_group_two_count }"
  facilities       = ["${ var.node_group_two_facility }"]
  plan             = "${ var.node_group_two_device_plan }" # Packet.net machine type
  billing_cycle    = "${ var.node_group_two_billing_cycle }" # hourly or monthly
  operating_system = "${ var.node_group_two_operating_system }"

}
