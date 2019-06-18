output "masters" { value = "${ join(",", packet_device.master.*.access_public_ipv4) }" }

output "workers" { value = "${ join(",", packet_device.worker.*.access_public_ipv4) }" }