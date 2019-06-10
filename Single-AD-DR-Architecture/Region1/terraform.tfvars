# AD (Availability Domain to use for creating EBS infrastructure) 
AD = ["1"]

# CIDR block of VCN to be created
vcn_cidr = "172.16.0.0/16"

#subnet cidr block
bastion_subnet_cidr_block = "172.16.10.0/24"
app_subnet_cidr_block = "172.16.20.0/24"
public_lb_subnet_cidr_block = "172.16.30.0/24"
private_lb_subnet_cidr_block = "172.16.40.0/24"
database_subnet_cidr_block = "172.16.50.0/24"
filestorage_subnet_cidr_block = "172.16.60.0/24"

#customer onpremises DC network
onpremises_network_cidr_block = "192.168.10.0/24"

# DNS label of VCN to be created
vcn_dns_label = "ebsvcn"

# Operating system version to be used for application instances
linux_os_version = "7.6"

# Timezone of compute instance
timezone = "America/New_York"

# Login user for bastion host
bastion_user = "opc"

# Size of boot volume (in gb) of application instances
compute_boot_volume_size_in_gb = "100"

# Login user for compute instance
compute_instance_user = "opc"

#Environment prefix to define name of resources
ebs_env_prefix = "ebsenv"

#Environment prefix to define name of DB
db_hostname_prefix = "dbdemo"

# Number of application instances to be created
ebs_app_instance_count = "3"

# Shape of app instance
ebs_app_instance_shape = "VM.Standard2.2"

# Listen port of the application instance
ebs_app_instance_listen_port = "8000"

# Mount path for application filesystem
ebs_fss_primary_mount_path = "/u01/install/APPS"

# Set filesystem limit
ebs_fss_limit_size_in_gb = "500"

# Datbase Edition
db_edition = "ENTERPRISE_EDITION_EXTREME_PERFORMANCE"

# Licensing model for database
db_license_model = "LICENSE_INCLUDED"

# Database version
db_version = "18.0.0.0"

# Number of database nodes
db_node_count = "1"

#Shape of Database nodes
db_instance_shape = "VM.Standard2.4"

#Database name
db_name = "EBSCDB"

#Size of Database
db_size_in_gb = "256"

# Database administration (sys) password
db_admin_password = "QAed12_sd#1AS"

# Characterset of database
db_characterset = "AL32UTF8"

# National Characterset of database
db_nls_characterset = "AL16UTF16"

# Pluggable database name
db_pdb_name = "DUMMYPDB"

# Shape of Load Balancer
load_balancer_shape = "100Mbps"

#Listen port of load balancer
load_balancer_listen_port = "8888"

#Public Hostname of Load Balancer
public_load_balancer_hostname = "pub.ebs.example.com"

#Private Hostname of Load Balancer
private_load_balancer_hostname = "pri.ebs.example.com"