output "node_group_one" { value = "${ join(" ", packet_device.node_group_one.*.access_public_ipv4) }" }

output "node_group_two" { value = "${ join(" ", packet_device.node_group_two.*.access_public_ipv4) }" }

output "node_group_three" { value = "${ join(" ", packet_device.node_group_three.*.access_public_ipv4) }" }