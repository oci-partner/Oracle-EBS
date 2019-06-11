resource "oci_core_route_table" "bastion_rt" {
    #Required
    compartment_id = "${var.compartment_ocid}"
    route_rules {
        #Required
        network_entity_id = "${oci_core_internet_gateway.igateway.id}"

        #Optional
        destination = "0.0.0.0/0"
        destination_type = "CIDR_BLOCK"
    }
    vcn_id = "${oci_core_vcn.ebsvcn.id}"

    #Optional
    display_name = "ebsbastionrt"
}
resource "oci_core_route_table" "database_rt" {
    #Required
    compartment_id = "${var.compartment_ocid}"
    route_rules {
        #Required
        network_entity_id = "${oci_core_nat_gateway.natgateway.id}"
        #Optional
        destination = "0.0.0.0/0"
        destination_type = "CIDR_BLOCK"
    }

    route_rules {
        destination_type = "SERVICE_CIDR_BLOCK"
        destination = "${lookup(data.oci_core_services.object_storage.services[0], "cidr_block")}"
        network_entity_id = "${oci_core_service_gateway.servicegateway.id}"
    }
    vcn_id = "${oci_core_vcn.ebsvcn.id}"
    #Optional
    display_name = "ebsdbroute"
}
resource "oci_core_route_table" "app_rt" {
    #Required
    compartment_id = "${var.compartment_ocid}"
    route_rules {
        #Required
        network_entity_id = "${oci_core_nat_gateway.natgateway.id}"
        #Optional
        destination = "0.0.0.0/0"
        destination_type = "CIDR_BLOCK"
    }

    vcn_id = "${oci_core_vcn.ebsvcn.id}"
    #Optional
    display_name = "ebsapproute"
}
resource "oci_core_route_table" "fss_rt" {
    #Required
    compartment_id = "${var.compartment_ocid}"
    route_rules {
        #Required
        network_entity_id = "${oci_core_nat_gateway.natgateway.id}"
        #Optional
        destination = "0.0.0.0/0"
        destination_type = "CIDR_BLOCK"
    }

    vcn_id = "${oci_core_vcn.ebsvcn.id}"
    #Optional
    display_name = "fssroute"
}
resource "oci_core_route_table" "drg_rt" {
    #Required
    compartment_id = "${var.compartment_ocid}"
    route_rules {
        #Required
        network_entity_id = "${oci_core_drg.drg.id}"
        #Optional
        destination = "${var.onpremises_network_cidr_block}"
        destination_type = "CIDR_BLOCK"
    }

    vcn_id = "${oci_core_vcn.ebsvcn.id}"
    #Optional
    display_name = "drgroute"
}