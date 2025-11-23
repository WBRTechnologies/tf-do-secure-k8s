output "cluster_id" {
  value = digitalocean_kubernetes_cluster.this.id
}

output "endpoint" {
  value = digitalocean_kubernetes_cluster.this.endpoint
}

output "kubeconfig" {
  value     = digitalocean_kubernetes_cluster.this.kube_config[0].raw_config
  sensitive = true
}

output "openvpn_public_ipv4" {
  value = "https://${digitalocean_droplet.openvpn.ipv4_address}:943"
}
