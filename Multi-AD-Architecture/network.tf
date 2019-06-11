# Virtual Cloud Network (VCN)
resource "oci_core_vcn" "ebsvcn" {
    #Required
    cidr_block = "${var.vcn_cidr}"
    compartment_id = "${var.compartment_ocid}"
    #Optional
    display_name = "ebsvcn"
    dns_label = "ebsvcn"
}
