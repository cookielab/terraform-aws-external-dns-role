resource "aws_iam_policy" "aws_external_dns" {
  name        = var.policy_name
  path        = "/"
  description = "Allows access to resources needed to run kubernetes cluster autoscaler."

  policy = <<JSON
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "route53:ChangeResourceRecordSets"
      ],
      "Resource": [
        "arn:aws:route53:::hostedzone/*"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "route53:ListHostedZones",
        "route53:ListResourceRecordSets"
      ],
      "Resource": [
        "*"
      ]
    }
  ]
}
JSON
}

resource "aws_iam_role" "aws_external_dns" {
  count = var.ec2_role_name == null ? 1 : 0

  name = var.role_name
  path = "/"

  assume_role_policy = <<JSON
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Effect": "Allow",
      "Principal": {
        "Federated": "${var.oidc_assume_role_arn}"
      }
    }
  ]
}
JSON
}

resource "aws_iam_role_policy_attachment" "aws_external_dns" {
  policy_arn = aws_iam_policy.aws_external_dns.arn
  role       = var.ec2_role_name == null ? aws_iam_role.aws_external_dns[0].name : var.ec2_role_name
}
