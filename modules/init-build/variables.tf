# Module variables
variable "working_dir" {
  type        = string
  default     = ""
  description = "The path to the working directory (Makefile location)."
}

variable "image_tag" {
  type        = string
  default     = "0.0.1"
  description = "The tag of the initial Docker image."
}

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
