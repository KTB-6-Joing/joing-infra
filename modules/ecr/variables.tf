variable "repository_name" {
  description = "Name of the ECR repository"
  type        = string
  default     = "joing-ecr-repo"
}

variable "image_tag_mutability" {
  description = "The tag mutability setting for the repository (MUTABLE or IMMUTABLE)"
  type        = string
  default     = "IMMUTABLE"
}

variable "scan_on_push" {
  description = "Indicates whether images are scanned after being pushed to the repository"
  type        = bool
  default     = true
}

variable "encryption_type" {
  description = "The encryption type for the repository (AES256 or KMS)"
  type        = string
  default     = "KMS"
}

variable "kms_key" {
  description = "The ARN of the KMS key to use when encryption_type is KMS. If not specified, uses the default AWS managed key"
  type        = string
  default     = null
}

variable "replication_regions" {
  description = "List of regions where ECR should be replicated"
  type        = list(string)
  default     = []
}

variable "lifecycle_policy" {
  description = "Map of lifecycle policies for the repository"
  type = object({
    untagged_image_expiration_days = optional(number, 14)
    max_image_count                = optional(number, 100)
    protected_tags                 = optional(list(string), ["latest", "stable", "production"])
  })
  default = {}
}

variable "tags" {
  description = "A map of tags to add to ECR repository"
  type        = map(string)
  default     = null // provider의 default tags와 병용
}