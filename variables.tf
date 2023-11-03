variable "instance_name" {
  description = "Name of instance."
  type        = string
  default     = "demo_test"

  validation {
    condition     = can(regex("_", var.instance_name))
    error_message = "The name value must have underscore '_' in it."
  }
}

variable "instance_type" {
  description = "Type of instance"
  type        = string
  default     = "t2.micro"

  validation {
    condition     = can(regex("\\.", var.instance_type))
    error_message = "The name value must have at dot '.' in it."
  }
}

variable "region_name" {
  description = "Region name"
  type        = string
  default     = "us-east-1"
}
