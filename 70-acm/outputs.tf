output "certificate_creation_output" {
    sensitive = true
    value = aws_acm_certificate.expense
}

output "certificate_validation_output"{
    value = aws_acm_certificate_validation.expense
}

