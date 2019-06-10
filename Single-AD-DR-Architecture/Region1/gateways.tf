# Internet Gateway
resource "oci_core_internet_gateway" "igateway" {
    #Required
    compartment_id = "${var.compartment_ocid}"
    vcn_id = "${oci_core_vcn.vcn.id}"
    #Optional
    enabled = "true"
    display_name = "igateway"
}

# NAT (Network Address Translation) Gateway
resource "oci_core_nat_gateway" "natgateway" {
    #Required
    compartment_id = "${var.compartment_ocid}"
    vcn_id = "${oci_core_vcn.vcn.id}"
    #Optional
    block_traffic = "false"
    display_name = "natgateway"
}


# Service Gateway
resource "oci_core_service_gateway" "servicegateway" {
    #Required
    compartment_id = "${var.compartment_ocid}"
    services {
        #Required
        service_id = "${lookup(data.oci_core_services.servicegateway_services.services[0], "id")}"
    }
    vcn_id = "${oci_core_vcn.vcn.id}"

    #Optional
    display_name = "servicegateway"
}

# Dynamic Routing Gateway (DRG)
resource "oci_core_drg" "drg" {
    #Required
    compartment_id = "${var.compartment_ocid}"
    #Optional
    display_name = "drg"
}

resource "oci_core_drg_attachment" "drg_attachment" {
    #Required
    drg_id = "${oci_core_drg.drg.id}"
    vcn_id = "${oci_core_vcn.vcn.id}"

    #Optional
    display_name = "drgatt"
    #route_table_id = "${oci_core_route_table.test_route_table.id}"
}