module "Network" {
    #==================== SOURCE
    source                = "./Modules/Network"
    #==================== VARS
    subnet_count          = var.subnet_count
    subnets               = var.subnets
    vpc_config            = var.vpc_config
    route_table_config    = var.route_table_config
    ingress_cidr_blocks   = var.ingress_cidr_blocks
    egress_cidr_blocks    = var.egress_cidr_blocks
    ingress_rules         = var.ingress_rules
    egress_rules          = var.egress_rules
    rules                 = var.rules
    tags                  = var.tags
}

module "Compute" {
    #==================== SOURCE
    source                = "./Modules/Compute"
    #==================== DEPENDS ON NETWORK
    depends_on            = [module.Network]

    SUBNET_IDs            = module.Network.SUBNET_IDs
    SEC_GROUP_ID          = module.Network.SEC_GROUP_ID
    VPC_GROUP_ID          = module.Network.VPC_GROUP_ID
    #==================== VARS
    subnet_count          = var.subnet_count
    tags                  = var.tags
    cluster_config        = var.cluster_config
    node_group_config     = var.node_group_config
}

module "Helm" {
    #==================== SOURCE
    source                = "./Modules/Helm"
    #==================== VARS
    dns_config            = var.dns_config
}