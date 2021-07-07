
variable "access_key" {}

variable "secret_key" {}

variable "aws_region" {
  description = "Region in which AWS resources to be created"
  type        = string
  default     = "us-east-1"
}
