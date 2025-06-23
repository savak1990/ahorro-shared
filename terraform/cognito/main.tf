resource "aws_cognito_user_pool" "this" {
  name = var.user_pool_name

  username_attributes      = ["email"]
  auto_verified_attributes = [] # No auto verification, enable "email" for prod
  mfa_configuration        = "OFF"

  // Uncomment the following line to enable email verification
  account_recovery_setting {
    recovery_mechanism {
      name     = "admin_only"
      priority = 1
    }
  }

  password_policy {
    minimum_length    = 8
    require_lowercase = true
    require_uppercase = true
    require_numbers   = true
    require_symbols   = false
  }

  schema {
    attribute_data_type = "String"
    name                = "email"
    required            = true
    mutable             = true
  }

  schema {
    attribute_data_type = "String"
    name                = "name"
    required            = true
    mutable             = true
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_cognito_user_pool_client" "this" {
  name            = var.user_pool_client_name
  user_pool_id    = aws_cognito_user_pool.this.id
  generate_secret = false
  explicit_auth_flows = [
    "ALLOW_USER_PASSWORD_AUTH",
    "ALLOW_REFRESH_TOKEN_AUTH",
    "ALLOW_USER_SRP_AUTH",
    "ALLOW_CUSTOM_AUTH"
  ]


  prevent_user_existence_errors = "ENABLED"
  read_attributes = [
    "email",
    "name"
  ]
}

resource "aws_cognito_user_pool_domain" "custom" {
  domain          = var.user_pool_fqdn
  user_pool_id    = aws_cognito_user_pool.this.id
  certificate_arn = var.acm_certificate_arn
}

resource "aws_route53_record" "cognito_custom_domain" {
  zone_id = var.zone_id
  name    = var.user_pool_fqdn
  type    = "A"

  alias {
    name                   = aws_cognito_user_pool_domain.custom.cloudfront_distribution_arn
    zone_id                = "Z2FDTNDATAQYW2"
    evaluate_target_health = false
  }
}
