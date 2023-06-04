variable "origin" {
  description = "One or more origins for this distribution (multiples allowed)."
  type        = any
}

variable "default_cache_behavior" {
  description = "The default cache behavior for this distribution"
  type        = any
}
