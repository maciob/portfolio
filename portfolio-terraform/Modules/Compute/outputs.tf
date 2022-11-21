output "CLUSTER_ENDPOINT" {
  description = "CLUSTER_ENDPOINT"
  value       = "${aws_eks_cluster.AWS_CLUSTER.endpoint}"
}
output "CLUSTER_CERTIFICATE_AUTHORITY" {
  description = "CLUSTER_CERTIFICATE_AUTHORITY"
  value       = "${aws_eks_cluster.AWS_CLUSTER.certificate_authority}"
}
