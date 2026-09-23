#################################################################################
# LOCAL FILE
#################################################################################
locals {
  values = yamldecode(
    file("${path.module}/userdata/values.yaml")
  )
}


##################################################################################
# AMAZON LINUX 2023 AMI
##################################################################################
data "aws_ami" "amazon_linux_2023" {

  most_recent = true
  owners      = ["amazon"]
  
  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}


###################################################################################
# CLOUD INIT
###################################################################################
data "cloudinit_config" "bastion_cloudinit" {

  gzip          = false
  base64_encode = false

  part {

    filename     = "cloud-init-bastion.yaml"

    content_type = "text/cloud-config"

    content = templatefile(
      "${path.module}/userdata/cloud-init-bastion.yaml",
      {

        ######################################################################
        # ENVIRONMENT
        ######################################################################

        env_name_prefix = local.values.environment.name_prefix

        aws_region = local.values.environment.aws_region

        ######################################################################
        # SSH
        ######################################################################

        bastion_ssh_key_1 = var.bastion_ssh_key_1
        bastion_ssh_key_2 = var.bastion_ssh_key_2
  
        ######################################################################
        # BASTION
        ######################################################################

        bastion_enabled = local.values.bastion.enabled

        bastion_instance_type = local.values.bastion.instance_type

        bastion_volume_size = local.values.bastion.volume_size

        ######################################################################
        # NETWORK
        ######################################################################

        vpc_cidr = local.values.network.vpc_cidr

        public_subnet_1 = local.values.network.public_subnet_1

        private_subnet_1 = local.values.network.private_subnet_1

        ######################################################################
        # SECURITY
        ######################################################################

        ssh_allowed_cidr = join(
          ",",
          local.values.security.ssh_allowed_cidr
        )

        ######################################################################
        # EKS
        ######################################################################

        eks_enabled = local.values.eks.enabled

        eks_cluster_name = local.values.eks.cluster_name

        eks_kubernetes_version = local.values.eks.kubernetes_version

        ######################################################################
        # LOGGING
        ######################################################################

        cloudwatch_enabled = local.values.logging.cloudwatch_enabled

        ######################################################################
        # S3
        ######################################################################

        log_bucket_enabled = local.values.s3.log_bucket_enabled
      }
    )
  }
}


##################################################################################
# BASTION SECURITY GROUP
##################################################################################

resource "aws_security_group" "bastion_sg" {

  name        = "${var.name}-bastion-sg"
  description = "Security Group for Bastion Host"
  vpc_id      = var.vpc_id

  ###########################################################################
  # SSH Access
  ###########################################################################
  ingress {

    description = "SSH Access"

    from_port   = 22
    to_port     = 22
    protocol    = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  ###########################################################################
  # Outbound HTTPS
  ###########################################################################
  egress {

    description = "HTTPS Outbound"

    from_port   = 443
    to_port     = 443
    protocol    = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  ###########################################################################
  # General Outbound Traffic
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
      Name = "${var.name}-bastion-sg"
    }
  )
}


####################################################################################
# BASTIOM ALB SECURITY GRP
####################################################################################
resource "aws_security_group_rule" "alb_to_bastion" {

  type = "ingress"

  from_port = 80
  to_port   = 80

  protocol = "tcp"

  security_group_id = aws_security_group.bastion_sg.id

  source_security_group_id = var.alb_sg_id
}

####################################################################################
# BASTION EC2 INSTANCE
####################################################################################
resource "aws_instance" "bastion" {

  ami = data.aws_ami.amazon_linux_2023.id

  instance_type = var.instance_type

  subnet_id     = var.subnet_id

  key_name      = var.key_name

  iam_instance_profile = var.instance_profile_name

  vpc_security_group_ids = [
    aws_security_group.bastion_sg.id
  ]

  associate_public_ip_address = var.associate_public_ip_address
  user_data = data.cloudinit_config.bastion_cloudinit.rendered

  tags = merge(
    var.tags,
    {
     Name = "${var.name}-bastion-server"
    }
  )
}

###################################################################################
# ELASTIC IP
###################################################################################

resource "aws_eip" "bastion_eip" {
  domain   = "vpc"

  tags     = merge(
    var.tags,
    {
     Name = "${var.name}-bastion-eip"
    }
  )
}

##################################################################################
# ELASTIC IP ASSOCIATION
##################################################################################

resource "aws_eip_association" "bastion_eip_assoc" {

  instance_id   = aws_instance.bastion.id

  allocation_id = aws_eip.bastion_eip.id
}
