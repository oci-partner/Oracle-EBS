#Environment Variables
variable "compartment_ocid" {}
variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}
variable "region" {}
variable "vcn_cidr" {}
variable "bastion_ssh_public_key" {}
variable "bastion_ssh_private_key" {}
variable "ssh_public_key" {}
variable "ssh_private_key" {}

### Network Variables
variable "bastion_subnet_cidr_block" {}
variable "app_subnet_cidr_block" {}
variable "public_lb_subnet_cidr_block" {}
variable "private_lb_subnet_cidr_block" {}
variable "database_subnet_cidr_block" {}
variable "filestorage_subnet_cidr_block" {}
variable "onpremises_network_cidr_block" {}

### EBS Variables
variable "ebs_env_prefix" {}
variable "ebs_app_instance_count" {}
variable "ebs_app_instance_shape" {}
variable "compute_boot_volume_size_in_gb" {}
variable "ebs_app_instance_listen_port" {}
variable "ebs_fss_limit_size_in_gb" {}
variable "compute_instance_user" {}
variable "bastion_user" {}
variable "ebs_fss_primary_mount_path" {}
variable "timezone" {}


### Instances Variables
variable "bastion_instance_shape" {
    default = "VM.Standard2.1"
}
variable "InstanceOS" {
    description = "Operating system for compute instances"
    default = "Oracle Linux" 
}

variable "linux_os_version" {
    description = "Operating system version for compute instances except NAT"
    default = "7.5"
}

#Local Variables
variable "AD" {
    description = "Availbility domain number"
    type        = "list"
}

### Load Balancer Variables
variable "load_balancer_shape" {}
variable "load_balancer_listen_port" {}
variable "private_load_balancer_hostname" {}
variable "public_load_balancer_hostname" {}

### Database Variables
variable "db_name" {}
variable "db_characterset" {}
variable "db_instance_shape" {}
variable "db_pdb_name" {}
variable "db_edition" {}
variable "db_size_in_gb" {}
variable "db_license_model" {}
variable "db_nls_characterset" {}
variable "db_node_count" {}
variable "db_admin_password" {}
variable "db_version" {}
