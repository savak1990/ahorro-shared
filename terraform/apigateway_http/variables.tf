variable "api_name" {
  description = "The name of the API Gateway."
  type        = string
}

variable "domain_name" {
  description = "The domain name for the API Gateway custom domain."
  type        = string
}

variable "zone_id" {
  description = "The Route53 hosted zone ID for the domain."
  type        = string
}

variable "certificate_arn" {
  description = "The ARN of the ACM certificate for the custom domain."
  type        = string
}

variable "lambda_name" {
  description = "The name of the Lambda function to inject into the OpenAPI spec."
  type        = string
}

variable "lambda_invoke_arn" {
  description = "The Lambda function invoke ARN to inject into the OpenAPI spec."
  type        = string
}

variable "cognito_user_pool_id" {
  description = "The Cognito User Pool ID for JWT authorizer."
  type        = string
}

variable "cognito_user_pool_client_id" {
  description = "The Cognito User Pool Client ID for JWT authorizer."
  type        = string
}

variable "cognito_auth_paths" {
  description = "List of API paths that require Cognito authentication."
  type        = list(string)
  default     = []
}

variable "cognito_unauth_paths" {
  description = "List of API paths that do not require Cognito authentication."
  type        = list(string)
  default     = []
}
