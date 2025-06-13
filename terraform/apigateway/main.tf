terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

# Render OpenAPI spec from template with Lambda ARN
locals {
  openapi_spec = templatefile(var.openapi_template_path, {
    lambda_invoke_arn = var.lambda_invoke_arn
  })
  fqdn = "${var.api_name}.${var.domain_name}"
}

# Create the API Gateway HTTP API with inline OpenAPI spec
resource "aws_apigatewayv2_api" "this" {
  name          = var.api_name
  protocol_type = "HTTP"
  body          = local.openapi_spec
}

resource "aws_apigatewayv2_integration" "lambda" {
  api_id                 = aws_apigatewayv2_api.this.id
  integration_type       = "AWS_PROXY"
  integration_uri        = var.lambda_invoke_arn
  integration_method     = "POST"
  payload_format_version = "2.0"
}

resource "aws_apigatewayv2_stage" "default" {
  api_id      = aws_apigatewayv2_api.this.id
  name        = "$default"
  auto_deploy = true
}

resource "aws_apigatewayv2_domain_name" "this" {
  domain_name = local.fqdn
  domain_name_configuration {
    certificate_arn = var.certificate_arn
    endpoint_type   = "REGIONAL"
    security_policy = "TLS_1_2"
  }
}

resource "aws_apigatewayv2_api_mapping" "this" {
  api_id      = aws_apigatewayv2_api.this.id
  domain_name = aws_apigatewayv2_domain_name.this.domain_name
  stage       = aws_apigatewayv2_stage.default.name
}

resource "aws_route53_record" "apigw" {
  zone_id = var.zone_id
  name    = local.fqdn
  type    = "A"
  alias {
    name                   = aws_apigatewayv2_domain_name.this.domain_name_configuration[0].target_domain_name
    zone_id                = aws_apigatewayv2_domain_name.this.domain_name_configuration[0].hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_lambda_permission" "apigw_invoke" {
  statement_id  = "${var.lambda_name}-allow-invoke"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.this.execution_arn}/*/*"
}
