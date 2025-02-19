variable "project_name" {
    default = "expense"
}

variable "environment" {
    default = "dev"
}

variable "common_tags" {
    default = {
        Project = "expense"
        Environment = "dev"
        Terraform = "true"
    }
}

variable "domain_name" {
    default = "raj82s.online"
}

variable "zone_id" {
    default = "Z02394622J1SSYR6C9O0N"
}