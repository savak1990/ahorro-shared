output "user_pool_id" {
  description = "The ID of the Cognito User Pool."
  value       = aws_cognito_user_pool.this.id
}

output "user_pool_client_id" {
  description = "The ID of the Cognito User Pool Client."
  value       = aws_cognito_user_pool_client.this.id
}

output "user_pool_arn" {
  description = "The ARN of the Cognito User Pool."
  value       = aws_cognito_user_pool.this.arn
}

output "user_pool_fqdn" {
  description = "The fully qualified domain name for the Cognito User Pool."
  value       = aws_cognito_user_pool_domain.custom.domain
  sensitive   = true
}
