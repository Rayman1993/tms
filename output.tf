output "server_instance_public_ip" {
    value = yandex_compute_instance.server.network_interface[0].nat_ip_address
}

output "agent_instance_public_ip" {
    value = yandex_compute_instance.agent.network_interface[0].nat_ip_address
}

output "subnet_id" {
    value = data.yandex_vpc_subnet.default_b.subnet_id
}

output "ubuntu22" {
    value = data.yandex_compute_image.ubuntu22.id
}

output "instance_ip_server" {
  value = yandex_compute_instance.server[*].network_interface[0].nat_ip_address
}

output "instance_ip_agent" {
  value = yandex_compute_instance.agent[*].network_interface[0].nat_ip_address
}