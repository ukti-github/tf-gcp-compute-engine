provider "google" {
  credentials = "${file("/home/mwar/Cloud/GCP/devops/devops-260809-1f72ec5132b0.json")}"
  project = "devops-260809"
  region = "us-west1"
}

resource "random_id" "instance_id" {
  byte_length = 8
}

resource "google_compute_instance" "default" {
  name = "flask-vm-${random_id.instance_id.hex}"
  machine_type = "f1-micro"
  zone = "us-west1-a"

  boot_disk{
      initialize_params {
          image = "debian-cloud/debian-9"
      }
  }

  metadata_startup_script = "sudo apt-get update; sudo apt-get install -yq build-essential python-pip rsync; pip install flask"

  network_interface {
      network = "default"
      access_config{
          // Include this section to give the VM an external ip address
      }
  }

}



