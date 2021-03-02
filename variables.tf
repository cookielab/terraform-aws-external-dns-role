variable "policy_name" {
  type        = string
  description = "IAM policy name (must be unique for whole account)"
  default     = "AmazonEKSExternalDNS"
}

variable "role_name" {
  type        = string
  description = "IAM role name (must be unique for whole account)"
  default     = "AmazonEKSExternalDNS"
}

variable "oidc_assume_role_arn" {
  type        = string
  description = "IAM OIDC provider arn (eg. aws_iam_openid_connect_provider.default.arn)"
  default = null
}

variable "ec2_role_name" {
  type        = string
  description = "EC2 IAM role name (eg. aws_iam_role.default_eks_node_group.name)"
  default = null
}

variable "tags" {
  type    = map(string)
  default = {}
}
