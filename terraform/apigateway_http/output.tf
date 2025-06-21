output "http_api_id" {
  description = "The ID of the HTTP API Gateway."
  value       = aws_apigatewayv2_api.this.id
}

output "http_api_execution_arn" {
  description = "The execution ARN of the HTTP API Gateway."
  value       = aws_apigatewayv2_api.this.execution_arn
}

output "api_gateway_url" {
  description = "The custom domain URL for the HTTP API Gateway."
  value       = "https://${aws_apigatewayv2_domain_name.this.domain_name}"
}
