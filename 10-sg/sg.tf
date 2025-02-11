module "mysql_sg" {
    source = "git::https://github.com/DAWS-2025-82S/12-terraform-aws-securitygroup.git?ref=main"
    project_name = var.project_name
    environment = var.environment
    sg_name = "mysql"
    sg_description = "Created for MySQL instances in expense dev"
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    common_tags = var.common_tags
}

# create separate group for all
module "backend_sg" {
    source = "git::https://github.com/DAWS-2025-82S/12-terraform-aws-securitygroup.git?ref=main"
    project_name = var.project_name
    environment = var.environment
    sg_name = "backend"
    sg_description = "Created for backend instances in expense dev"
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    common_tags = var.common_tags
}

module "frontend_sg" {
    source = "git::https://github.com/DAWS-2025-82S/12-terraform-aws-securitygroup.git?ref=main"
    project_name = var.project_name
    environment = var.environment
    sg_name = "frontend"
    sg_description = "Created for frontend instances in expense dev"
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    common_tags = var.common_tags
}

module "bastion_sg" {
    source = "git::https://github.com/DAWS-2025-82S/12-terraform-aws-securitygroup.git?ref=main"
    project_name = var.project_name
    environment = var.environment
    sg_name = "bastion"
    sg_description = "Created for bastion instances in expense dev"
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    common_tags = var.common_tags
}

module "app_alb_sg" {
    source = "git::https://github.com/DAWS-2025-82S/12-terraform-aws-securitygroup.git?ref=main"
    project_name = var.project_name
    environment = var.environment
    sg_name = "app-alb"
    sg_description = "Created for application load(backend) balancer in expense dev"
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    common_tags = var.common_tags
}

# APP ALB(Backend Load Balancer) accepting traffic from bastion security group instead of IP
# here we are not  configuring Bastion IP bcoz it may change
resource "aws_security_group_rule" "app_alb_bastion" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp" 
  # configuring bastion security group instead of Bastion IP(cidr)
  source_security_group_id  = module.bastion_sg.sg_id
  security_group_id = module.app_alb_sg.sg_id
}

# To acess Bastion instance using public IP
resource "aws_security_group_rule" "bastion_public" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp" 
  cidr_blocks = ["49.37.219.75/32"] # Provide your local system IP # This IP is not fixed and it will change
  security_group_id = module.bastion_sg.sg_id
}

