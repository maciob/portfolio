resource "aws_eks_cluster" "AWS_CLUSTER" {
    name     = var.cluster_config["name"]
    role_arn = var.cluster_config["arn_role"]
    vpc_config {
        security_group_ids = [var.SEC_GROUP_ID]
        subnet_ids = var.SUBNET_IDs
    }
    version  = var.cluster_config["version"]
    tags = {
        Name         = var.cluster_config["name"]
        Owner       = var.tags["Owner"]
        expiration_date = var.tags["expiration_date"]
        bootcamp    = var.tags["bootcamp"]
    }
}

resource "aws_eks_node_group" "AWS_NODE" {
    cluster_name     = aws_eks_cluster.AWS_CLUSTER.name
    node_group_name  = var.node_group_config["name"]
    node_role_arn    = var.node_group_config["arn_role"]
    subnet_ids       = var.SUBNET_IDs
    instance_types   = [ var.node_group_config["instance_type"] ]
    scaling_config {
        desired_size = var.node_group_config["instance_count"]
        max_size     = var.node_group_config["instance_count"]
        min_size     = var.node_group_config["instance_count"]
    }

    tags = {
        Name         = var.node_group_config["name"]
        Owner       = var.tags["Owner"]
        expiration_date = var.tags["expiration_date"]
        bootcamp    = var.tags["bootcamp"]
    }
}