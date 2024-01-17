variable "region" {
  description = "AWS region"
  default     = "sa-east-1"
}


# Environment variables to ECS Task - It is stored on Terraform Cloud
variable "URL_SANDBOX" {
}

variable "USERNAME" {
}

variable "PASSWORD" {
}

variable "TF_TOKEN" {
}

variable "TF_ACCESS_URL" {
}

variable "TF_ACCESS_ID" {
}

variable "TF_SECRET_URL" {
}

variable "TF_SECRET_ID" {
}

variable "QTD_SERVERS" {
}

