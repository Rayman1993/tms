terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

provider "yandex" {
  token     = var.token
  cloud_id  = "b1gnvrgj455dg0ds6pc8"
  folder_id = var.yandex_folder_id
  zone      = "ru-central1-b"
}

data "yandex_compute_image" "ubuntu22" {
  family = "ubuntu-2204-lts"
}

data "yandex_vpc_subnet" "default_b" {
  name = "default-ru-central1-b"
}

resource "yandex_compute_instance" "server" { 
  name = "jenkins-server"
  allow_stopping_for_update = true
	platform_id = "standard-v1"

  resources {
    core_fraction = 100
    cores  = 4
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu22.id
      size = 20
    }
  }

  network_interface {
    subnet_id = data.yandex_vpc_subnet.default_b.subnet_id
    nat = true
  }

  metadata = {
    user-data = "${file("./meta.yml")}"
    ssh-keys = "ubuntu:${file(var.ssh)}"
  }

  labels = {
    id = "jenkins-server"
  }
}

resource "yandex_compute_instance" "agent" { 
  name = "jenkins-agent"
  allow_stopping_for_update = true
	platform_id = "standard-v1"

  resources {
    core_fraction = 100
    cores  = 4
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu22.id
      size = 20
    }
  }

  network_interface {
    subnet_id = data.yandex_vpc_subnet.default_b.subnet_id
    nat = true
  }

  metadata = {
    user-data = "${file("./meta.yml")}"
    ssh-keys = "ubuntu:${file(var.ssh)}"
  }

  labels = {
    id = "jenkins-agent"
  }
}