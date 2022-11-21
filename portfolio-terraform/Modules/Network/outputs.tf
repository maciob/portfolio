output "SUBNET_IDs" {
  description = "SUBNET_IDs"
  value       = "${aws_subnet.AWS_SUBNETS[*].id}"
}
output "SEC_GROUP_ID" {
  description = "SEC_GROUP_ID"
  value       = "${aws_security_group.AWS_SEC.id}"
}
output "VPC_GROUP_ID" {
  description = "VPC_GROUP_ID"
  value       = "${aws_vpc.AWS_VPC.id}"
}