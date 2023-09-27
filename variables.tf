variable "context" {
  type        = string
  default     = "k3d-east"
  description = "The context to use for kubectl [k3d-east, k3d-west]"
  validation {
    condition     = contains(["k3d-east", "k3d-west"], var.context)
    error_message = "The context cannot be empty"
  }
}


variable "name" {
  type        = string
  default     = "tf-controller-test"
  description = "The name of the namespace"
}