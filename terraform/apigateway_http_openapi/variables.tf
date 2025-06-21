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

variable "openapi_template_path" {
  description = "Path to the OpenAPI template file."
  type        = string
}

variable "openapi_template_replacements" {
  description = "Map of replacements for the OpenAPI templatefile function. Keys should match template variables."
  type        = map(string)
  default     = {}
}
