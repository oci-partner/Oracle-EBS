data "oci_core_services" "servicegateway_services" {
	filter {
		name = "name"
		values = [".*Object.*Storage"]
		regex = true
	}
}