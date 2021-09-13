# Initial build image
resource "null_resource" "build" {
  provisioner "local-exec" {
    command     = "make build"
    working_dir = var.working_dir
    environment = {
      REGISTRY_ID       = data.aws_caller_identity.current.account_id
      REPOSITORY_REGION = data.aws_region.current.name
      APP               = var.app
      ENV               = var.env
      NAME_CONTAINER    = var.name_container
      TAG               = var.image_tag
    }
  }
}
