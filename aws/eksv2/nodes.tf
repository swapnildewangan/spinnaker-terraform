resource "aws_iam_role" "nodes" {
  name = "eks-node-group-nodes-demo-spinnaker"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "nodes-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.nodes.name
}

resource "aws_iam_role_policy_attachment" "nodes-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.nodes.name
}

resource "aws_iam_role_policy_attachment" "nodes-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.nodes.name
}


resource "aws_security_group" "eks_cluster_sg" {
  vpc_id = aws_vpc.main.id
}

# resource "aws_launch_configuration" "eks_nodes" {
#   name          = "eks-nodes"
#   instance_type = "t2.medium"
#   image_id      = "ami-03d1ae8551d035e3d"
#
#   lifecycle {
#     create_before_destroy = true
#   }
#
#   security_groups = [
#     aws_security_group.eks_cluster_sg.id,
#   ]
# }
#
# resource "aws_autoscaling_group" "eks_asg" {
#   min_size             = 3
#   max_size             = 3
#   launch_configuration = aws_launch_configuration.eks_nodes.id
#   desired_capacity     = 3
#
#   vpc_zone_identifier = [
#      aws_subnet.demo-spinnaker-private-us-east-1a.id,
#      aws_subnet.demo-spinnaker-private-us-east-1b.id,
#      aws_subnet.demo-spinnaker-private-us-east-1c.id
#   ]
# }

resource "aws_lb" "app_lb" {
  name               = "app-lb"
  load_balancer_type = "application"
  internal           = false

  security_groups = [
    aws_security_group.eks_cluster_sg.id,
  ]

  subnets = [
    aws_subnet.demo-spinnaker-public-us-east-1a.id,
    aws_subnet.demo-spinnaker-public-us-east-1b.id,
    aws_subnet.demo-spinnaker-public-us-east-1c.id
  ]
}

resource "aws_lb_target_group" "app_tg" {
  vpc_id   = aws_vpc.main.id
  protocol = "HTTP"
  port     = 80
  name     = "app-tg"
}

resource "aws_lb_listener" "app_lb_listener" {
  protocol          = "HTTP"
  port              = 80
  load_balancer_arn = aws_lb.app_lb.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }
}

#  resource "aws_autoscaling_attachment" "asg_attachment" {
#    alb_target_group_arn    = aws_lb_target_group.app_tg.arn
#    autoscaling_group_name = aws_autoscaling_group.eks_asg.name
#  }

resource "aws_eks_node_group" "private-nodes" {
  cluster_name    = aws_eks_cluster.demo.name
  node_group_name = "private-nodes"
  node_role_arn   = aws_iam_role.nodes.arn

  subnet_ids = [
    aws_subnet.demo-spinnaker-private-us-east-1a.id,
    aws_subnet.demo-spinnaker-private-us-east-1b.id,
    aws_subnet.demo-spinnaker-private-us-east-1c.id
  ]

  capacity_type  = "ON_DEMAND"
  instance_types = ["t3.small"]

  scaling_config {
    desired_size = 3
    max_size     = 3
    min_size     = 3
  }

  update_config {
    max_unavailable = 1
  }

  labels = {
    role = "general"
  }

  depends_on = [
    aws_iam_role_policy_attachment.nodes-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.nodes-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.nodes-AmazonEC2ContainerRegistryReadOnly,
  ]
}