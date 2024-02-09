# Configure the HuaweiCloud Provider

# Configs that came from root variables.tf (tf.vars)

provider "huaweicloud" {
  region     = var.region[0]
  access_key = var.access_key
  secret_key = var.secret_key
  project_id = var.project_id
  insecure   = true
  
}

# Creating Modules based on ./vpc files (main.tf, variables.tf)

# Modules 

module "vpcmod" {
	source = "./vpc"
	region = var.region[0]

	vpc = [
	{
		vpc_name = "my-vpc2"
		vpc_cidr = "10.144.0.0/21"
		 vpc_subnet = [
		 	{
		 		sub_name = "snet-pre-hub-private-saperu1-01"
		 		sub_cidr = "10.144.0.0/24"
		 		sub_gateway = "10.144.0.1"
		 	}

		]
	}
	]
}

# Module security group

module "sgroupmod" {
  source = "./secgroup"

  security_groups = [
    {
      name        = "sg_terraform_01"
      description = "Security Group 1"
      inbound_rules = [
        {
          protocol        = "tcp"
          port_range_min  = 8080
          port_range_max  = 8080
          remote_ip_prefix = "0.0.0.0/0"
        }
      ]
      outbound_rules = [
        {
          protocol        = "tcp"
          port_range_min  = 8080
          port_range_max  = 8080
          remote_ip_prefix = "0.0.0.0/0"
        }
      ]
    }
    # Add more security group configurations as needed
  ]
}


# Criando Módulos baseados nos arquivos ./ecs (main.tf, variables.tf)

# Módulos

module "ecsmod" {
  source     = "./ecs"
  secgroup_id = "710b23ac-dd88-4ce1-ba24-eba17134fd48"

  ecs_instances = [
    {
      instance_name     = "myinstance"
      image_id          = "68a783a4-25b2-4069-bc25-d927eeb7f97b"
      flavor_id         = "s6.small.1"
    #   key_pair          = "my_key_pair_name"
      availability_zone = "sa-brazil-1b"
      network_uuid      = [
        {
          uuid = "0a9352bd-dcae-43b2-91d1-6185f5bf8b66"
        }
      ]
    }
  ]
}
