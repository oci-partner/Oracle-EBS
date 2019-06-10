module "create_bastion" {
    source = "./modules/bastion"
    compartment_ocid        = "${var.compartment_ocid}"
    AD                      = "${var.AD}"
    availability_domain     = ["${data.template_file.deployment_ad.*.rendered}"]
    bastion_hostname_prefix = "${var.ebs_env_prefix}-bastion" //${substr(var.region, 3, 3)}"
    bastion_image           = "${data.oci_core_images.InstanceImageOCID.images.0.id}"
    bastion_instance_shape  = "${var.bastion_instance_shape}"
    bastion_subnet          = ["${oci_core_subnet.bastion_subnet.id}"]
    bastion_ssh_public_key  = "${var.bastion_ssh_public_key}"
}
module "create_app" {
    source  = "./modules/compute"

    compartment_ocid                = "${var.compartment_ocid}"
    AD                              = "${var.AD}"
    availability_domain             = ["${data.template_file.deployment_ad.*.rendered}"]
    fault_domain                    = ["${sort(data.template_file.deployment_fd.*.rendered)}"]
    compute_instance_count          = "${var.ebs_app_instance_count}"
    compute_hostname_prefix         = "${var.ebs_env_prefix}-app" //${substr(var.region, 3, 3)}"
    compute_image                   = "${data.oci_core_images.InstanceImageOCID.images.0.id}"
    compute_instance_shape          = "${var.ebs_app_instance_shape}"
    compute_subnet                  = ["${oci_core_subnet.app_subnet.id}"]
    compute_ssh_public_key          = "${var.ssh_public_key}"
    compute_ssh_private_key         = "${var.ssh_private_key}"
    bastion_ssh_private_key         = "${var.bastion_ssh_private_key}"
    bastion_public_ip               = "${module.create_bastion.Bastion_Public_IPs[0]}"
    compute_instance_listen_port    = "${var.ebs_app_instance_listen_port}"
    fss_instance_prefix             = "${var.ebs_env_prefix}-fss" //${substr(var.region, 3, 3)}"
    fss_subnet                      = ["${oci_core_subnet.fss_subnet.id}"]
    fss_primary_mount_path          = "${var.ebs_fss_primary_mount_path}"
    fss_limit_size_in_gb            = "${var.ebs_fss_limit_size_in_gb}"
    compute_instance_user           = "${var.compute_instance_user}"
    bastion_user                    = "${var.bastion_user}"
    compute_boot_volume_size_in_gb  = "${var.compute_boot_volume_size_in_gb}"
    timezone                        = "${var.timezone}"
}

module "create_db" {
    source  = "./modules/dbsystem"

    compartment_ocid      = "${var.compartment_ocid}"
    AD                    = "${var.AD}"
    availability_domain   = ["${data.template_file.deployment_ad.*.rendered}"]
    db_edition            = "${var.db_edition}"
    db_instance_shape     = "${var.db_instance_shape}"
    db_node_count         = "${var.db_node_count}"
    db_hostname_prefix    = "${var.ebs_env_prefix}-db" //${substr(var.region, 3, 3)}"
    db_size_in_gb         = "${var.db_size_in_gb}"
    db_license_model      = "${var.db_license_model}"
    db_subnet             = ["${oci_core_subnet.database_subnet.id}"]
    db_ssh_public_key     = "${var.ssh_public_key}"
    db_admin_password     = "${var.db_admin_password}"
    db_name               = "${var.db_name}"
    db_characterset       = "${var.db_characterset}"
    db_nls_characterset   = "${var.db_nls_characterset}"
    db_version            = "${var.db_version}"
    db_pdb_name           = "${var.db_pdb_name}"
}
module "create_public_lb" {
    source  = "./modules/loadbalancer"

    compartment_ocid              = "${var.compartment_ocid}"
    AD                            = "${var.AD}"
    lb_count                      = ["1"]
    availability_domain           = ["${data.template_file.deployment_ad.*.rendered}"]
    load_balancer_shape           = "${var.load_balancer_shape}"
    load_balancer_subnet          = ["${oci_core_subnet.public_lb_subnet.id}"]
    load_balancer_name            = "${var.ebs_env_prefix}-publb" //${substr(var.region, 3, 3)}"
    load_balancer_hostname        = "${var.public_load_balancer_hostname}"
    load_balancer_listen_port     = "${var.load_balancer_listen_port}"
    compute_instance_listen_port  = "${var.ebs_app_instance_listen_port}"
    compute_instance_count        = "${var.ebs_app_instance_count}"
    be_ip_addresses               = ["${module.create_app.AppsPrvIPs}"]
    load_balancer_private         = "False"
}

module "create_private_lb" {
    source  = "./modules/loadbalancer"

    compartment_ocid              = "${var.compartment_ocid}"
    AD                            = "${var.AD}"
    lb_count                      = ["1"]
    availability_domain           = ["${data.template_file.deployment_ad.*.rendered}"]
    load_balancer_shape           = "${var.load_balancer_shape}"
    load_balancer_subnet          = ["${oci_core_subnet.private_lb_subnet.id}"]
    load_balancer_name            = "${var.ebs_env_prefix}-prilb" //${substr(var.region, 3, 3)}"
    load_balancer_hostname        = "${var.private_load_balancer_hostname}"
    load_balancer_listen_port     = "${var.load_balancer_listen_port}"
    compute_instance_listen_port  = "${var.ebs_app_instance_listen_port}"
    compute_instance_count        = "${var.ebs_app_instance_count}"
    be_ip_addresses               = ["${module.create_app.AppsPrvIPs}"]
}