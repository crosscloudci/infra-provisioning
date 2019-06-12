resource "packet_device" "master" {
  count            = "${ var.packet_master_node_count }"
  hostname         = "${ var.name }${ count.index + 1 }"
  facility         = "${ var.packet_facility }"
  project_id       = "${ var.packet_project_id }"
  plan             = "${ var.packet_master_device_plan }" # Packet.net machine type
  billing_cycle    = "${ var.packet_billing_cycle }" # hourly or monthly
  operating_system = "${ var.packet_operating_system }"
 
}

resource "packet_device" "worker" {
  count            = "${ var.packet_worker_node_count }"
  hostname         = "${ var.name }${ count.index + 1 }"
  facility         = "${ var.packet_facility }"
  project_id       = "${ var.packet_project_id }"
  plan             = "${ var.packet_worker_device_plan }" # Packet.net machine type
  billing_cycle    = "${ var.packet_billing_cycle }" # hourly or monthly
  operating_system = "${ var.packet_operating_system }"
 
}
