resource "oci_core_subnet" "bastionnet" {
    #Required
    cidr_block = "${var.bastion_subnet_cidr_block}"
    compartment_id = "${var.compartment_ocid}"
    vcn_id = "${oci_core_vcn.ebsvcn.id}"

    #Optional
    availability_domain = ""
    #dhcp_options_id = "${oci_core_dhcp_options.test_dhcp_options.id}"
    display_name = "bastionnet"
    dns_label = "bastionnet"
    prohibit_public_ip_on_vnic = "false"
    route_table_id = "${oci_core_route_table.bastion_rt.id}"
    security_list_ids = ["${oci_core_security_list.bastionseclist.id}"]
}

resource "oci_core_subnet" "backupnet" {
    #Required
    cidr_block = "${var.backup_subnet_cidr_block}"
    compartment_id = "${var.compartment_ocid}"
    vcn_id = "${oci_core_vcn.ebsvcn.id}"

    #Optional
    availability_domain = ""
    #dhcp_options_id = "${oci_core_dhcp_options.test_dhcp_options.id}"
    display_name = "backupnet"
    dns_label = "backupnet"
    prohibit_public_ip_on_vnic = "true"
    route_table_id = "${oci_core_route_table.database_rt.id}"
    security_list_ids = ["${oci_core_security_list.backupseclist.id}"]
}

### Application Sub Network
resource "oci_core_subnet" "appnet" {
    #Required
    cidr_block = "${var.app_subnet_cidr_block}"
    compartment_id = "${var.compartment_ocid}"
    vcn_id = "${oci_core_vcn.ebsvcn.id}"

    #Optional
    availability_domain = ""
    #dhcp_options_id = "${oci_core_dhcp_options.test_dhcp_options.id}"
    display_name = "appnet"
    dns_label = "appnet"
    prohibit_public_ip_on_vnic = "true"
    route_table_id = "${oci_core_route_table.app_rt.id}"
    security_list_ids = ["${oci_core_security_list.appseclist.id}"]//,"${oci_core_security_list.ebs12seclist.id}"]
}
### Load Balancer Sub Network
resource "oci_core_subnet" "lbsubnetpub" {
    #Required
    cidr_block = "${var.public_lb_subnet_cidr_block}"
    compartment_id = "${var.compartment_ocid}"
    vcn_id = "${oci_core_vcn.ebsvcn.id}"

    #Optional
    availability_domain = ""
    #dhcp_options_id = "${oci_core_dhcp_options.test_dhcp_options.id}"
    display_name = "lbsubnetpub"
    dns_label = "lbsubnetpub"
    prohibit_public_ip_on_vnic = "false"
    route_table_id = "${oci_core_route_table.bastion_rt.id}"
    security_list_ids = ["${oci_core_security_list.publbseclist.id}"]
}

resource "oci_core_subnet" "lbsubnetpriv" {
    #Required
    cidr_block = "${var.private_lb_subnet_cidr_block}"
    compartment_id = "${var.compartment_ocid}"
    vcn_id = "${oci_core_vcn.ebsvcn.id}"

    #Optional
    availability_domain = ""
    #dhcp_options_id = "${oci_core_dhcp_options.test_dhcp_options.id}"
    display_name = "lbsubnetpriv"
    dns_label = "lbsubnetpriv"
    prohibit_public_ip_on_vnic = "true"
    route_table_id = "${oci_core_route_table.drg_rt.id}"
    security_list_ids = ["${oci_core_security_list.privlbseclist.id}"]
}

resource "oci_core_subnet" "dbnet" {
    #Required
    cidr_block = "${var.database_subnet_cidr_block}"
    compartment_id = "${var.compartment_ocid}"
    vcn_id = "${oci_core_vcn.ebsvcn.id}"

    #Optional
    availability_domain = ""
    #dhcp_options_id = "${oci_core_dhcp_options.test_dhcp_options.id}"
    display_name = "dbnet"
    dns_label = "dbnet"
    prohibit_public_ip_on_vnic = "true"
    route_table_id = "${oci_core_route_table.database_rt.id}"
    security_list_ids = ["${oci_core_security_list.dbseclist.id}"]//,"${oci_core_security_list.hexdseclist.id}"]
}

resource "oci_core_subnet" "fssnet" {
    #Required
    cidr_block = "${var.filestorage_subnet_cidr_block}"
    compartment_id = "${var.compartment_ocid}"
    vcn_id = "${oci_core_vcn.ebsvcn.id}"

    #Optional
    availability_domain = ""
    #dhcp_options_id = "${oci_core_dhcp_options.test_dhcp_options.id}"
    display_name = "fssnet"
    dns_label = "fssnet"
    prohibit_public_ip_on_vnic = "true"
    route_table_id = "${oci_core_route_table.fss_rt.id}"
    security_list_ids = ["${oci_core_security_list.fssseclist.id}"]
}
