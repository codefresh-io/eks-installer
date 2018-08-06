#
# Variables Configuration
#

variable "cluster-name" {
  default = "terraform-eks-demo"
  type    = "string"
}

variable "cluster-size" {
  default = "1"
  type    = "string"
}

variable "cluster-region" {
  default = "us-west-2"
  type    = "string"
}

variable "cluster-instance-type" {
  default = "m4.large"
  type    = "string"
}

variable "key-pair-name" {
  default = "default"
  type    = "string"
}

variable "key-pair-public-key" {
  default = "default"
  type    = "string"
}
