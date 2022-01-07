variable "ami_id" {
  type = string
}
variable "instance_type" {
  type = string
  default = "t2.micro"
}
variable "associate_public_ip" {
  type = string
  default = true
}
variable "subnet_id" {
  type = string
  default = null
}
variable "key_pair" {
  type = string
  default = null
}
variable "security_group_ids" {
  type = list(string)
  default = null
}
variable "environment" {
  type = string
}