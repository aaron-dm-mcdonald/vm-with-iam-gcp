output "project_id" {
  value = local.project_id
}

output "vm_url" {
  value = "http://${google_compute_instance.sample_vm.network_interface[0].access_config[0].nat_ip}"
  description = "Public HTTP URL for the sample_vm instance"
}

output "ssh_command" {
  value = "gcloud compute ssh ${google_compute_instance.sample_vm.name} --zone ${google_compute_instance.sample_vm.zone}"
  description = "Use this command to SSH into the instance"
}
