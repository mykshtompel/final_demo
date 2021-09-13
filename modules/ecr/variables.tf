# Module variables
variable "env" {
  type        = string
  default     = "env"
  description = "The name of the environment."
}

variable "app" {
  type        = string
  default     = "app"
  description = "The name of the application."
}

variable "name_container" {
  type        = string
  default     = "container"
  description = "The name of the container."
}
