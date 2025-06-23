variable "user_pool_name" {
  description = "Name of the Cognito user pool."
  type        = string
}

variable "user_pool_client_name" {
  description = "Name of the Cognito user pool client."
  type        = string
}

variable "user_pool_fqdn" {
  description = "Fully qualified domain name for the Cognito user pool."
  type        = string
}

variable "acm_certificate_arn" {
  description = "ARN of the ACM certificate for the Cognito user pool domain."
  type        = string
}

variable "zone_id" {
  description = "The Route53 hosted zone ID for the Cognito user pool domain."
  type        = string
}
