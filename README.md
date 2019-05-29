# Oracle EBS on OCI - Terraform modules for Partners

## Summary
Oracle E-Business suite architecture blueprint helps you design and execute a process in a systematic manner that is free from any loopholes and eliminates any guess works. This architecture blueprint captures every detail of your offline process and hence, streamlining the process becomes easy to implement Oracle E-Business suite on Oracle Cloud Infrastructure. This Oracle E-Business suite architecture is designed to be highly available for each layer of the application stack and highly secure to protects application from malicious and unwanted internet traffic while running on Oracle Cloud Infrastructure.

Every production environment of Oracle E-Business suite requires additional 2-3 similar environment used for test/dev, QA or user acceptance. However, all those additional environments can be down size depending on nature of workload and type of usage. This architecture blueprint designed to run an Oracle E-Business suite production work load.   

[Learn more about Oracle E-Business Suite](https://www.oracle.com/applications/ebusiness)
[Learn more about Oracle Cloud Infrastructure](https://docs.cloud.oracle.com/iaas/Content/GSG/Concepts/baremetalintro.htm)

## Target Audience 
This blueprint is intended for Oracle partners and customers who want to implement and learn about the benefits and options for running Oracle E-Business suite on Oracle Cloud Infrastructure. This blueprint talks about the best practices for high availability, disaster recovery, security, and management of Oracle E-Business suite on Oracle Cloud Infrastructure. This architecture blueprint designed to scale up to 5000 concurrent users process at a 75% threshold point of app tier and database tier.

## In-Scope services
There are few other OCI integration services used on this architecture in addition to the OCI compute, network and storage components. For example, access management, auditing, policies, object storage and service gateway etc. are used to ensure the Oracle E-Business suite environment is secure and it supports business continuity in case of disaster. However, it is out of the scope to design this architecture to meet the individual customer RPO and RTO requirements. Individual customer needs to customize the architecture to meet their RPO and RTO requirement. 

## Oracle EBS Architecture 
At very high level there are three different tiers are part of Oracle E-Business Suite. Client tier connects to the application tier, where all application logic, form server, web server and concurrent processing server are running. The application server connects to database server to read and write data from the application tables stored in the Oracle database. A load balancer used to appropriately balance all user/client connections to application server. 

| Component  | Function |
| ------------- | ------------- |
| EBS Application Server 1  | Application server running web services, form services and concurrent processing services. mainly used for high availability and parallel processing of client request. |
| EBS Application Server 2  | Application server running web services, form services and concurrent processing services. mainly used for high availability and parallel processing of client request. |
| EBS Application Server 3 | Application server running web services, form services and concurrent processing services. mainly used for high availability and parallel processing of client request. |
| Load Balancer | Oracle Cloud Infrastructure load balancer. provides automatic load balancing of EBS client connection across multiple EBS application server. |
| EBS Database Server | An Oracle database cloud service used to store application schemas for EBS application. |

The following diagram illustrates the relationship between the components of the Oracle E-Business Suite deployment.
[EBS Architecture](./_docs/EBS-Suite-Deployment.jpg)

## Prerequisites

1. [Download and install Terraform](https://www.terraform.io/downloads.html) (v0.11.8 or later)
2. Export OCI credentials using guidance at [Export Credentials](https://www.terraform.io/docs/providers/oci/index.html).

## Oracle E-Business Suite Terraform modules structure

Terraform modules for Oracle E-Business Suite has the following structure:

```
.
├── datasources.tf
├── _docs
│   ├── multiple_availability_domain_ha_topology.png
│   ├── single_availability_domain_ha_topology.png
│   └── terraform-init.png
├── env-vars
├── env-vars.ps1
├── LICENSE.md
├── main.tf
├── modules
│   ├── bastion
│   │   ├── bastion.outputs.tf
│   │   ├── bastion.tf
│   │   └── bastion.vars.tf
│   ├── compute
│   │   ├── compute.data.tf
│   │   ├── compute.outputs.tf
│   │   ├── compute.rsync-remote-exec.tf
│   │   ├── compute.tf
│   │   ├── compute.variables.tf
│   │   ├── fss.tf
│   │   └── userdata
│   │       ├── bootstrap.tpl
│   │       └── rsync.sh
│   ├── database
│   │   ├── db.datasources.tf
│   │   ├── db.dbsystem.tf
│   │   └── db.variables.tf
│   ├── loadbalancer
│   │   ├── lb.tf
│   │   └── lb.variables.tf
│   └── network
│       ├── subnets
│       │   ├── subnets.outputs.tf
│       │   ├── subnets.tf
│       │   └── subnets.variables.tf
│       └── vcn
│           ├── vcn.data.tf
│           ├── vcn.outputs.tf
│           ├── vcn.tf
│           └── vcn.vars.tf
├── outputs.tf
├── provider.tf
├── README.md
├── routetables.tf
├── seclists.tf
├── terraform.tfvars
└── variables.tf

10 directories, 38 files

```

- [**root**]:
  - [env-vars]: This is an environment file to set terraform environment variables on UNIX systems.
  - [env-vars.ps1]: This is an environment file to set terraform environment variables on Windows systems.
  - [datasources.tf]: This is terraform data source file to fetch data for Oracle Cloud Infrastructure resources.
  - [main.tf]: At root level, main.tf calls different modules to create Oracle Cloud Infrastructure resources. 
  - [outputs.tf]: This is the terraform outputs file.
  - [provider.tf]: This is the terraform provider file that defines the provider (Oracle Cloud Infrastructure) and authentication information.
  - [variables.tf]: This is the terraform variables file to declare variables.
  - [routetables.tf]: This file creates route tables.
  - [seclists.tf]: This file creates security lists.
  - [terraform.tfvars]: This is an input file to pass values to declared variables.

- [**modules**]: The modules directory contain all the modules required for creating Oracle Cloud Infrastructure resources.
  - [bastion]: This module is used to create bastion hosts.
  - [compute]: This module is used  to create unix and windows compute instances.
  - [dbsystem]: This module is used to create Oracle Cloud Infrastructure database system.
  - [loadbalancer]: This module is used to create Oracle Cloud Infrastructure load Balancing service.
  - [network]: This module is used to create network resources like VCN (Virtual Cloud Network),subnets, internet gateway, service gateway, dynamic routing gateway and NAT (network Address Translation) gateway.
    - [vcn]: This sub module creates the VCN, internet gateway, service gateway, dynamic routing gateway and NAT gateway.
    - [subnets]: This sub module creates the subnets within a VCN.
    
## Inputs required in the terraform.tfvars file

The following inputs are required for terraform modules:

| Argument                   | Description                                                                                                                                                                                                                                                                                                                                                       |
| -------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| AD                         | Availability Domain for Oracle E-Business Suite Deployment. This variable drives the Oracle E-Business Suite architecture to be deployed. Setting AD = ["1"] deploys infrastructure in single availability domain (Availabilty domain 1 of the tenancy in this case) and AD = ["1","2"] deploys infrastructure in multiple ADs (Availability domains 1 and 2 of the tenancy in this case). |
| vcn_cidr                   | CIDR block of the VCN (Virtual Cloud Network) to be created.                                                                                                                                                                                                      |
| vcn_dns_label              | DNS Label of the VCN (Virtual Cloud Network) to be created.                                                                                                                                                                                                                                                                                                                               |
| linux_os_version           | Operating system version of Oracle Linux for compute instances. The terraform module for compute instances always pick up the latest image available for the chosen Oracle Linux version in the region.                                                                                                                        |
| timezone                   | Timezone of compute instances.                                                                                                                                                                                                                                                                                                                                  |
| bastion_user               | User name to log in to bastion host.                                                                                                                                                                                                                                                                                                                              |
| compute_boot_volume_size_in_gb | Size of boot volume in gb for compute instance.                                                                                                                                                                                                                                                                                                               |
| compute_instance_user          | User name to log in to compute instance.                                                                                                                                                                                                                                                                                                                      |
| ebs_env_prefix                 | Environment prefix to define names of Oracle Cloud infrastructure resources.                                                                                                                                                                                                                                                                                                                   |
| ebs_app_instance_count     | Number of Oracle E-Business suite application instances to be created. For single availability domain architecture, all application instances will be created in the chosen availability domain. For multiple availability domain architetcure, all application instances will be distributed in round robin fashion across the chosen availability domains.                                                                   |
| ebs_app_instance_shape         | Shape of application instance. For more information on available shapes, see [VM Shapes](https://docs.cloud.oracle.com/iaas/Content/Compute/References/computeshapes.htm?TocPath=Services#vmshapes)                                                                                                                                                               |
| ebs_app_instance_listen_port   | Port on which Oracle E-Business Suite application instance will listen and receive requests from Oracle Cloud Infrastructure Load Balancing Service.                                                                                                                                                                                                                                                                                             |
| ebs_fss_primary_mount_path | Mount path for Oracle E-Business Suite application primary filesystem. For example /u01/install/APPS.                                                                                                                                                                                                                                                                                     |
| ebs_fss_limit_size_in_gb | Soft upper limit for Oracle E-Business Suite application primary filesystem. This value is defined just to set an upper soft size limit visible to Oracle E-Business Installation tools. It does not restrict storage size of File Storage Service.                                                                                                                                                                                                                                                                                     |
| db_edition                 | Edition of database.     
| db_license_model           | Licensing model for database.                                                                                                                                                                                                                                                                                                                                     |
| db_version                 | Version of database.                                                                                                                                                                                                                                                                                                                                              |
| db_node_count              | Number of database nodes. For single instance database, this parameter should be 1 and for Real Application Cluster Database, this parameter should be set to 2.                                                                                                                                                                                                  |
| db_instance_shape          | Shape of Database nodes. For RAC, the minimum required shape is VMStandard1.2.                                                                                                                                                                                                                                                                                    |  
| db_name                    | Name of Database Container.                                                                                                                                                                                                                                                                                                                                                    |
| db_size_in_gb              | Size of database in gb. For more information, see [Oracle Cloud Infrastructure Images](https://docs.cloud.oracle.com/iaas/images/)                                                                                                                                                                                                                                      |
| db_admin_password          | Database administration password (sys password).                                                                                                                                                                                                                                                                                                                  |  
| db_characterset            | Characterset of database.                                                                                                                                                                                                                                                                                                                                         |
| db_nls_characterset        | National Characterset of database.                                                                                                                                                                                                                                                                                                                                     |                                                                                                                                                                                                                                                                                                                                     |
| db_pdb_name                | Starter Pluggable database name.                                                                                                                                                                                                                                                                                                                                          |
| load_balancer_hostname     | Hostname of the load balancer.                                                                                                                                                                                                                                                                                                                                    |
| load_balancer_shape        | Shape of the load balancer.                                                                                                                                                                                                                                                                                                                                       |
| load_balancer_listen_port  | Listen port of the load balancer.                                                                                                                                                                                                                                                                                                                                 |
                                                                                                                                                               |

##### Sample terraform.tfvars file to create Oracle E-Business Suite infrastructure in multiple availability domain architecture

```hcl
# AD (Availability Domain to use for creating EBS infrastructure) 
AD = ["1","2"]

# CIDR block of VCN to be created
vcn_cidr = "172.16.0.0/16"

# DNS label of VCN to be created
vcn_dns_label = "ebsvcn"

# Operating system version to be used for application instances
linux_os_version = "7.5"

# Timezone of compute instance
timezone = "America/New_York"

# Login user for bastion host
bastion_user = "opc"

# Size of boot volume (in gb) of application instances
compute_boot_volume_size_in_gb = "100"

# Login user for compute instance
compute_instance_user = "opc"

#Environment prefix to define name of resources
ebs_env_prefix = "ebsdemo"

# Number of application instances to be created
ebs_app_instance_count = "2"

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
db_version = "12.1.0.2"

# Number of database nodes
db_node_count = "2"

#Shape of Database nodes
db_instance_shape = "VM.Standard2.4"

#Database name
db_name = "EBSCDB"

#Size of Database
db_size_in_gb = "256"

# Database administration (sys) password
db_admin_password = "<password>"

# Characterset of database
db_characterset = "AL32UTF8"

# National Characterset of database
db_nls_characterset = "AL16UTF16"

# Pluggable database name
db_pdb_name = "DUMMYPDB"

# Hostname of Load Balancer
load_balancer_hostname = "ebs.example.com"

# Shape of Load Balancer
load_balancer_shape = "100Mbps"

#Listen port of load balancer
load_balancer_listen_port = "8888"
```

If you want to deploy Oracle E-Business Suite on Oracle Cloud Infrastructure in single availability domain architecture, set AD variable to one of the availability domain i.e. 1, 2 or 3. 

```hcl
AD = ["1"]
```

## Information about Oracle Cloud Infrastructure resources built by Terraform modules for Oracle E-Business Suite

* It is recommended to use shared filesystem for Oracle E-Business Suite multi tier configuration. The Terraform modules create File     Storage service filesystem for single as well as multiple availability domain architecture. For a single availability domain architecture, a single filesystem is created. For multiple availability domain architecture, two such file systems are created, one in each availabilty domain. 

* The filesystems can be synchronized by an rsync script in cron. The rsync snchronization script is placed in cron of root user and is commented by default. The script can be enabled to synchornize fileystems after implemenation of Oracle E-Business Suite. 

  ```
  # Credits to lucas.gomes@oracle.com
  # crontab -l
  */30 * * * * /usr/bin/flock -n /var/run/fss-sync-up-file-system.lck rsync -aHAXxv --numeric-ids --delete /u01/install/APPS/ /u01/install/APPSDR/

  # cat /etc/cron.d/fss-sync-up-file-system
  */30 * * * * /usr/bin/flock -n /var/run/fss-sync-up-file-system.lck rsync -aHAXxv --numeric-ids --delete /u01/install/APPS /u01/install/APPSDR
  ```

* The Terraform modules creates one private load balancer for single availability domain architecture and two private load balancers for multiple availability domain architecture. For a multiple availability domain architecture, the backend set of each private load balancer has application servers from respective availablity domains.

* Separate pairs of SSH keys can be used for bastion host and rest of the compute infrastructure resources. It is also possible to use the same key. In that case, same key is required as input to instance and bastion instance variables in env-vars or env-vars.ps1 file.

  For example,
  ```
  ### Public/private keys used on the instance
  export TF_VAR_ssh_public_key=/home/oracle/tf/<mykey.pub>
  export TF_VAR_ssh_private_key=/home/oracle/tf/<mykey.pem>

  ### Public/private keys used on the bastion instance
  export TF_VAR_bastion_ssh_public_key=/home/oracle/tf/<mykey.pub>
  export TF_VAR_bastion_ssh_private_key=/home/oracle/tf/<mykey.pem>

  ```
  For terraform installations on Unix systems, the private half of SSH key pairs should be in OpenSSH format. The instances in private subnet can be reached via SSH on port 22 by allowing agent forwarding in Putty and using Putty authentication tool like Pageant. Note that this does not require copying private SSH key for instances to bastion host.

* The terraform modules ensure that application instances are deployed across different Fault Domains within an availability domain. Fault Domains protect against unexpected hardware failures and against planned outages due to compute hardware maintenance. For Real application clusters database, each node of cluster is deployed in a separate Fault domains by default.

* The terraform modules expose timezone variable which can be used to set timezone of provisioned compute instances. The modules uses cloud-init to do that. For database system, timezone has to be set manually using operating system specific procedure. Follow operating system specific documentation to do that.

* The Terraform modules always use latest Oracle Linux image for the chosen operating system for provisioning compute instances. 
There are chances that minor version of operating system gets upgraded and a new image gets published in Oracle Cloud Infrastructure console. In that case, always check the available version of image from oracle Cloud Infrastructure compute console to input this value. For example, if Oracle Linux version is chnaged from version 7.5 to 7.6, change this value from 7.5 to 7.6.  

* The standby database has to be built manually after your Oracle E-Business Suite database is restored. For creating a standby database, see [Using Oracle Data Guard with the Database CLI](https://docs.cloud.oracle.com/iaas/Content/Database/Tasks/usingDG.htm?tocpath=Services%7CDatabase%7CBare%20Metal%20and%20Virtual%20Machine%20DB%20Systems%7C_____11)

* The terraform version has been locked to 0.11.8 and Oracle Cloud Infrastructure provider version has been locked to 3.5.1 in provider.tf file. To use a version higher than these versions, change the values in the provider.tf file. The terraform modules may require changes for a successful run with a new terraform and Oracle Cloud Infrastructure provider version. 


## Cloud-init template for application servers

Following is the cloud-init template used to install Oracle E-Business Suite prerequisite RPMs and mount shared file systems on application servers:

```yaml
#cloud-config
timezone: "${timezone}"

packages:
  - rsync
  - nfs-utils
  - ntp
  - oracle-ebs-server-R12-preinstall

runcmd:
  - sudo mkdir -p ${src_mount_path}
  - sudo mount ${src_mount_target_private_ip}:${src_export_path} ${src_mount_path}
  - sudo chown oracle:oinstall ${src_mount_path}
  - echo ${src_mount_target_private_ip}:${src_export_path} ${src_mount_path} nfs tcp,vers=3 >> /etc/fstab
  # Run firewall command to enable to open ports
  - firewall-offline-cmd --port=${app_instance_listen_port}:tcp
  - /bin/systemctl restart firewalld
```

## Unix bash commands to configure rsync on application servers.

These are the unix commands run to enable rsync across Oracle E-Business Suite application servers.

```
#Copyright © 2018, Oracle and/or its affiliates. All rights reserved.

#The Universal Permissive License (UPL), Version 1.0


#/bin/bash
sudo mkdir -p ${dst_mount_path}
sudo mount ${dst_mount_target_private_ip}:${dst_export_path} ${dst_mount_path}
sudo chown oracle:oinstall ${dst_mount_path}
sudo crontab /etc/cron.d/fss-sync-up-file-system
echo '${dst_mount_target_private_ip}:${dst_export_path} ${dst_mount_path} nfs tcp,vers=3' | sudo tee -a /etc/fstab
echo '#${fss_sync_frequency} /usr/bin/flock -n /var/run/fss-sync-up-file-system.lck rsync -aHAXxv --numeric-ids --delete ${src_mount_path} ${dst_mount_path}' | sudo tee -a /etc/cron.d/fss-sync-up-file-system
touch /tmp/rsync.done
```
## How to use this module

1) Go to EBusinessSuite directory

```
$ cd EBusinessSuite
```

2) Update **env-vars** (or **env-vars.ps1** for Windows) with the required information. The file contains definitions of environment variables for your Oracle Cloud Infrastructure tenancy.

3) Update **terraform.tfvars** with the inputs for the architecture that you want to build. A running sample terraform.tfvars file for multiple availability domain architecture is available in previous section. The contents of sample file can be copied to create a running terraform.tfvars input file. Update db_admin_password with actual password in terraform.tfvars file.

4) Initialize Terraform. This will also download the latest terraform oci provider.


  ```
  $ terraform init
  ```
  ![terraform init](./_docs/terraform-init.png)


5) Set environment variables by running source **env-vars** on your UNIX system or by running **env-vars.ps1** on your Windows system.

  ```
  $ source env-vars
  ```

6) Run terraform apply to create the infrastructure:

  ```
  $ terraform apply
  ```
 
  When you’re prompted to confirm the action, enter **yes**.

  When all components have been created, Terraform displays a completion message. For example: Apply complete! Resources: 47 added, 0 changed, 0 destroyed.


7) If you want to delete the infrastructure, run:

  ```
  $ terraform destroy
  ```

  When you’re prompted to confirm the action, enter **yes**.


# License
Copyright © 2018, Oracle and/or its affiliates. All rights reserved. 
The Universal Permissive License (UPL), Version 1.0 
Please see LICENSE.md for full details