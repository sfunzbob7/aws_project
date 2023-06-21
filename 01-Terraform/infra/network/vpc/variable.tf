variable "vpc_cidr" {
  default = "10.2.0.0/16"
}

variable "public_subnet" {
  type    = list(any)
  default = ["10.2.0.0/24", "10.2.16.0/24"]
}

variable "private_subnet" {
  type    = list(any)
  default = ["10.2.64.0/24", "10.2.80.0/24"]
}

variable "azs" {
  type    = list(any)
  default = ["ap-northeast-2a", "ap-northeast-2c"]
}