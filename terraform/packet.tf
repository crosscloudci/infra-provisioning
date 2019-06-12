resource "packet_device" "cncf" {
  count            = "${ var.packet_node_count }"
  hostname         = "${ var.name }${ count.index + 1 }"
  facility         = "${ var.packet_facility }"
  project_id       = "${ var.packet_project_id }"
  plan             = "${ var.packet_master_device_plan }" # Packet.net machine type
  billing_cycle    = "${ var.packet_billing_cycle }" # hourly or monthly
  operating_system = "${ var.packet_operating_system }"
 
}
