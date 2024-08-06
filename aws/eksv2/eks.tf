resource "aws_iam_role" "demo" {
  name = "eks-cluster-demo-spinnaker"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "demo-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.demo.name
}

resource "aws_eks_cluster" "demo" {
  name     = "demo-spinnaker-cluster"
  role_arn = aws_iam_role.demo.arn

  vpc_config {
    subnet_ids = [
      aws_subnet.demo-spinnaker-private-us-east-1a.id,
      aws_subnet.demo-spinnaker-private-us-east-1b.id,
      aws_subnet.demo-spinnaker-private-us-east-1c.id,
      aws_subnet.demo-spinnaker-public-us-east-1a.id,
      aws_subnet.demo-spinnaker-public-us-east-1b.id,
      aws_subnet.demo-spinnaker-public-us-east-1c.id
    ]
  }

  depends_on = [aws_iam_role_policy_attachment.demo-AmazonEKSClusterPolicy]
}
