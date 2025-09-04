variable "instance_type" {
  description = "instace for deploying app"
  type = string
  default = "t3.micro"
}

variable "key_name" {
  description = "ssh key"
  type = string
  default = "suyash"
}