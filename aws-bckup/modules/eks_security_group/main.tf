##################################################################################
# EKS SECURITY GROUP
##################################################################################

resource "aws_security_group" "eks_cluster" {

  name        = "${var.name}-eks-sg"
  description = "Security Group for EKS Worker Nodes"
  vpc_id      = var.vpc_id

  ###########################################################################
  # Node-to-Node Communication
  ###########################################################################
  ingress {

    description = "Allow all traffic between EKS worker nodes"

    from_port = 0
    to_port   = 0
    protocol  = "-1"

    self = true
  }

  ###########################################################################
  # Bastion -> EKS Worker Nodes
  ###########################################################################
  ingress {

    description = "Allow Bastion access to worker nodes"

    from_port       = 0
    to_port         = 0
    protocol        = "-1"

    security_groups = [var.bastion_sg_id]
  }

  ###########################################################################
  # Outbound Traffic
  ###########################################################################
  egress {

    description = "Allow all outbound traffic"

    from_port   = 0
    to_port     = 0
    protocol    = "-1"

    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.name}-eks-sg"
    }
  )
}
