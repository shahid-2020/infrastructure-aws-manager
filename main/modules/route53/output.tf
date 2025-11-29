output "zone_id" {
  description = "The hosted zone ID"
  value       = aws_route53_zone.this.zone_id
}

output "name_servers" {
  description = "A list of name servers in associated (or default) delegation set"
  value       = aws_route53_zone.this.name_servers
}

output "arn" {
  description = "The ARN of the hosted zone"
  value       = aws_route53_zone.this.arn
}

