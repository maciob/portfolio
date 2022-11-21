resource "aws_internet_gateway" "AWS_IGW" {
    vpc_id = aws_vpc.AWS_VPC.id
    tags = {
        Name        = "MBekas-portfolio-IGW"
        Owner       = var.tags["Owner"]
        expiration_date = var.tags["expiration_date"]
        bootcamp    = var.tags["bootcamp"]
    }
}

resource "aws_route_table" "AWS_RT" {
    vpc_id = aws_vpc.AWS_VPC.id
    route {
        cidr_block = var.route_table_config["cidr"]
        gateway_id = aws_internet_gateway.AWS_IGW.id
    }
    tags = {
        Name        = "MBekas-portfolio-RT"
        Owner       = var.tags["Owner"]
        expiration_date = var.tags["expiration_date"]
        bootcamp    = var.tags["bootcamp"]
    }
}

resource "aws_route_table_association" "AWS_RTA" {
    count          = length(aws_subnet.AWS_SUBNETS)
    subnet_id      = aws_subnet.AWS_SUBNETS[count.index].id
    route_table_id = aws_route_table.AWS_RT.id
}

resource "aws_security_group" "AWS_SEC" {
    vpc_id = aws_vpc.AWS_VPC.id
    tags = {
        Name        = "MBekas-portfolio-SEC"
        Owner       = var.tags["Owner"]
        expiration_date = var.tags["expiration_date"]
        bootcamp    = var.tags["bootcamp"]
    }
}

resource "aws_security_group_rule" "INGRESS" {
    count             = length(var.ingress_rules)
    security_group_id = aws_security_group.AWS_SEC.id
    type              = "ingress"
    cidr_blocks       = var.ingress_cidr_blocks
    from_port         = var.rules[var.ingress_rules[count.index]][0]
    to_port           = var.rules[var.ingress_rules[count.index]][1]
    protocol          = var.rules[var.ingress_rules[count.index]][2]
}

resource "aws_security_group_rule" "EGRESS" {
    count             = length(var.egress_rules)
    security_group_id = aws_security_group.AWS_SEC.id
    type              = "egress"
    cidr_blocks       = var.egress_cidr_blocks
    from_port         = var.rules[var.egress_rules[count.index]][0]
    to_port           = var.rules[var.egress_rules[count.index]][1]
    protocol          = var.rules[var.egress_rules[count.index]][2]
}