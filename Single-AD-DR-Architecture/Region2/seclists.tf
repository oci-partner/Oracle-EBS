resource "oci_core_security_list" "bastion_sl" {
    #Required
    compartment_id = "${var.compartment_ocid}"
    vcn_id = "${oci_core_vcn.vcn.id}"
    #Optional
    display_name = "bastion_sl"

    egress_security_rules {
        #Required
        destination = "0.0.0.0/0"
        protocol = "all"
        stateless = "false"
    }

    # Allow SSH to DB
    egress_security_rules {
        destination = "${oci_core_subnet.database_subnet.cidr_block}"
        protocol = "6"
        tcp_options {
            max = "22"
            min = "22"
        }
    }

    # Allow SSH to Apps
    egress_security_rules {
        destination = "${oci_core_subnet.app_subnet.cidr_block}"
        protocol = "6"
        tcp_options {
            max = "22"
            min = "22"
        }
    }

    ingress_security_rules {
        #Required
        protocol = "6" // TCP number protocol
        source = "0.0.0.0/0"

        source_type = "CIDR_BLOCK"
        stateless = "false"
        tcp_options {
            #Optional
            max = "22"
            min = "22"
        }
    }

    ingress_security_rules {
        protocol  = "1" // ICMP
        source    = "0.0.0.0/0"
        stateless = "false"

        icmp_options {
            type = "3"
            code = "4"
        }
    }

    ingress_security_rules {
        protocol  = "1" // ICMP
        source    = "${oci_core_vcn.vcn.cidr_block}"
        stateless = "false"

        icmp_options {
            type = "3"
        }
    }
}


resource "oci_core_security_list" "database_sl" {
    #Required
    compartment_id = "${var.compartment_ocid}"
    vcn_id = "${oci_core_vcn.vcn.id}"
    #Optional
    display_name = "database_sl"

    egress_security_rules {
        #Required
        destination_type = "SERVICE_CIDR_BLOCK"
        destination = "${lookup(data.oci_core_services.object_storage.services[0], "cidr_block")}"
        protocol = "6"
        stateless = "false"
        tcp_options {
            max = "443"
            min = "443"
        }
    }

    egress_security_rules {
        destination = "0.0.0.0/0"
        protocol = "all"
        stateless = "false"
    }
}


resource "oci_core_security_list" "app_sl" {
    #Required
    compartment_id = "${var.compartment_ocid}"
    vcn_id = "${oci_core_vcn.vcn.id}"
    #Optional
    display_name = "app_sl"

    egress_security_rules {
        #Required
        destination = "${oci_core_subnet.database_subnet.cidr_block}"
        protocol = "6"
        stateless = "false"
        tcp_options {
            max = "1521"
            min = "1521"
        }
    }

    ingress_security_rules {
        protocol  = "6" // ICMP
        source    = "0.0.0.0/0"
        stateless = "false"

        tcp_options {
            max = "8888"
            min = "8888"
        }
    }

    ingress_security_rules {
        protocol  = "6" // ICMP
        source    = "0.0.0.0/0"
        stateless = "false"

        tcp_options {
            max = "443"
            min = "443"
        }
    }
}

resource "oci_core_security_list" "public_lb_sl" {
    #Required
    compartment_id = "${var.compartment_ocid}"
    vcn_id = "${oci_core_vcn.vcn.id}"
    #Optional
    display_name = "public_lb_sl"

    ingress_security_rules {
        source = "0.0.0.0/0"
        protocol = "6"
        stateless = "false"

        tcp_options {
            max = "8000"
            min = "8000"
        }
    }

    egress_security_rules {
        #Required
        destination = "${oci_core_subnet.app_subnet.cidr_block}"
        protocol = "6"
        stateless = "false"
        tcp_options {
            max = "8000"
            min = "8000"
        }
    }

    egress_security_rules {
        #Required
        destination = "${oci_core_subnet.app_subnet.cidr_block}"
        protocol = "6"
        stateless = "false"
        tcp_options {
            max = "8000"
            min = "8000"
        }
    }
}

resource "oci_core_security_list" "private_lb_sl" {
    #Required
    compartment_id = "${var.compartment_ocid}"
    vcn_id = "${oci_core_vcn.vcn.id}"
    #Optional
    display_name = "private_lb_sl"

    ingress_security_rules {
        source = "${var.onpremises_network_cidr_block}"
        protocol = "6"
        stateless = "false"

        tcp_options {
            max = "8000"
            min = "8000"
        }
    }

    egress_security_rules {
        #Required
        destination = "${oci_core_subnet.app_subnet.cidr_block}"
        protocol = "6"
        stateless = "false"
        tcp_options {
            max = "8000"
            min = "8000"
        }
    }

    egress_security_rules {
        #Required
        destination = "${oci_core_subnet.app_subnet.cidr_block}"
        protocol = "6"
        stateless = "false"
        tcp_options {
            max = "8000"
            min = "8000"
        }
    }
}

resource "oci_core_security_list" "fss_sl" {
    #Required
    compartment_id = "${var.compartment_ocid}"
    vcn_id = "${oci_core_vcn.vcn.id}"
    #Optional
    display_name = "fss_sl"

    ingress_security_rules {
        protocol  = "6" // TCP
        source    = "${oci_core_vcn.vcn.cidr_block}"
        stateless = "false"

        tcp_options {
            max = "2050"
            min = "2048"
        }
    }

    ingress_security_rules {
        protocol  = "6" // TCP
        source    = "${oci_core_vcn.vcn.cidr_block}"
        stateless = "false"

        tcp_options {
            max = "111"
            min = "111"
        }
    }

    ingress_security_rules {
        protocol  = "17" // UDP
        source    = "${oci_core_vcn.vcn.cidr_block}"
        stateless = "false"

        udp_options {
            max = "2048"
            min = "2048"
        }
    }

    ingress_security_rules {
        protocol  = "17" // UDP
        source    = "${oci_core_vcn.vcn.cidr_block}"
        stateless = "false"

        udp_options {
            max = "111"
            min = "111"
        }
    }

    egress_security_rules {
        #Required
        destination = "${oci_core_vcn.vcn.cidr_block}"
        protocol = "6" // TCP
        stateless = "false"
        tcp_options {
            max = "2050"
            min = "2048"
        }
    }

    egress_security_rules {
        #Required
        destination = "${oci_core_vcn.vcn.cidr_block}"
        protocol = "6" // TCP
        stateless = "false"
        tcp_options {
            max = "111"
            min = "111"
        }
    }

    egress_security_rules {
        #Required
        destination = "${oci_core_vcn.vcn.cidr_block}"
        protocol = "17" // UDP
        stateless = "false"
        udp_options {
            max = "111"
            min = "111"
        }
    }
}