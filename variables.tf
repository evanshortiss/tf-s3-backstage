variable "bucket_name"   {
  type = string
  validation {
    condition     = can(regex("^[a-z0-9.-]{3,63}$", var.bucket_name))
    error_message = "3–63 chars, lowercase letters, numbers, dots, and hyphens."
  }
}

variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "versioning_on" {
  type    = bool
  default = true
}
