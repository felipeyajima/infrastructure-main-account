resource "aws_ecr_repository" "ecr_registry_turnon" {
  name                 = "turnon"
  image_tag_mutability = "MUTABLE"
  
}
