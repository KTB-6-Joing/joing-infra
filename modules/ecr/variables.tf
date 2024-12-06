variable "repositories" {
  description = "Names of the ECR repositories"
  type        = map(string)
  default = {
    rec_ai = "joing-recai-repo"
    gen_ai = "joing-genai-repo"
    be     = "joing-backend-repo"
  }
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

variable "replication_regions" {
  description = "List of regions where ECR should be replicated"
  type        = list(string)
  default     = ["ap-northeast-1", "us-east-1"]
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
