resource "oci_core_subnet" "bastion_subnet" {
    #Required
    cidr_block = "${var.bastion_subnet_cidr_block}"
    compartment_id = "${var.compartment_ocid}"
    vcn_id = "${oci_core_vcn.vcn.id}"

    #Optional
    availability_domain = ""
    #dhcp_options_id = "${oci_core_dhcp_options.test_dhcp_options.id}"
    display_name = "bastion_subnet"
    dns_label = "bastion"
    prohibit_public_ip_on_vnic = "false"
    route_table_id = "${oci_core_route_table.bastion_rt.id}"
    security_list_ids = ["${oci_core_security_list.bastion_sl.id}"]
}

### Application Sub Network
resource "oci_core_subnet" "app_subnet" {
    #Required
    cidr_block = "${var.app_subnet_cidr_block}"
    compartment_id = "${var.compartment_ocid}"
    vcn_id = "${oci_core_vcn.vcn.id}"

    #Optional
    availability_domain = ""
    #dhcp_options_id = "${oci_core_dhcp_options.test_dhcp_options.id}"
    display_name = "app_subnet"
    dns_label = "application"
    prohibit_public_ip_on_vnic = "true"
    route_table_id = "${oci_core_route_table.app_rt.id}"
    security_list_ids = ["${oci_core_security_list.app_sl.id}"]
}
### Load Balancer Sub Network
resource "oci_core_subnet" "public_lb_subnet" {
    #Required
    cidr_block = "${var.public_lb_subnet_cidr_block}"
    compartment_id = "${var.compartment_ocid}"
    vcn_id = "${oci_core_vcn.vcn.id}"

    #Optional
    availability_domain = ""
    #dhcp_options_id = "${oci_core_dhcp_options.test_dhcp_options.id}"
    display_name = "public_lb_subnet"
    dns_label = "publoadbalancer"
    prohibit_public_ip_on_vnic = "false"
    //route_table_id = "${oci_core_route_table.bastion_rt.id}"
    security_list_ids = ["${oci_core_security_list.public_lb_sl.id}"]
}

resource "oci_core_subnet" "private_lb_subnet" {
    #Required
    cidr_block = "${var.private_lb_subnet_cidr_block}"
    compartment_id = "${var.compartment_ocid}"
    vcn_id = "${oci_core_vcn.vcn.id}"

    #Optional
    availability_domain = ""
    #dhcp_options_id = "${oci_core_dhcp_options.test_dhcp_options.id}"
    display_name = "private_lb_subnet"
    dns_label = "priloadbalancer"
    prohibit_public_ip_on_vnic = "true"
    //route_table_id = "${oci_core_route_table.bastion_rt.id}"
    security_list_ids = ["${oci_core_security_list.private_lb_sl.id}"]
}

resource "oci_core_subnet" "database_subnet" {
    #Required
    cidr_block = "${var.database_subnet_cidr_block}"
    compartment_id = "${var.compartment_ocid}"
    vcn_id = "${oci_core_vcn.vcn.id}"

    #Optional
    availability_domain = ""
    #dhcp_options_id = "${oci_core_dhcp_options.test_dhcp_options.id}"
    display_name = "private_db_subnet"
    dns_label = "database"
    prohibit_public_ip_on_vnic = "true"
    route_table_id = "${oci_core_route_table.database_rt.id}"
    security_list_ids = ["${oci_core_security_list.database_sl.id}"]
}

resource "oci_core_subnet" "fss_subnet" {
    #Required
    cidr_block = "${var.filestorage_subnet_cidr_block}"
    compartment_id = "${var.compartment_ocid}"
    vcn_id = "${oci_core_vcn.vcn.id}"

    #Optional
    availability_domain = ""
    #dhcp_options_id = "${oci_core_dhcp_options.test_dhcp_options.id}"
    display_name = "fss_subnet"
    dns_label = "filesystem"
    prohibit_public_ip_on_vnic = "true"
    //route_table_id = "${oci_core_route_table.bastion_rt.id}"
    security_list_ids = ["${oci_core_security_list.fss_sl.id}"]
}
