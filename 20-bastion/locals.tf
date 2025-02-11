locals{
    public_subnet_id=split(",",data.aws_ssm_parameter.public_subnet_ids.value)[0]
    bastion_subnet_id_output="Bastion Public Subnet id=${local.public_subnet_id}"
}