output "masters" { value = "${ packet_device.master.*.access_public_ipv4 }" }

output "workers" { value = "${ packet_device.worker.*.access_public_ipv4 }" }