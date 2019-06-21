output "public_ip" {
  value = "${element(oci_load_balancer.lb.ip_addresses,1)}"
}
