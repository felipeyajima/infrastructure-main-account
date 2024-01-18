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


variable "ecr-vars"{
  default = [
        {
          "name": "URL_SANDBOX",
          "value": var.URL_SANDBOX
        },
        {
          "name": "USERNAME",
          "value": var.USERNAME
        },
        {
          "name": "PASSWORD",
          "value": var.PASSWORD
        },
        {
          "name": "TF_TOKEN",
          "value": var.TF_TOKEN
        },
        {
          "name": "TF_ACCESS_URL",
          "value": var.TF_ACCESS_URL
        },
        {
          "name": "TF_ACCESS_ID",
          "value": var.TF_ACCESS_ID
        },
        {
          "name": "TF_SECRET_URL",
          "value": var.TF_SECRET_URL
        },
        {
          "name": "TF_SECRET_ID",
          "value": var.TF_SECRET_ID
        },
        {
          "name": "QTD_SERVERS",
          "value": var.QTD_SERVERS
        }
      ]
}

