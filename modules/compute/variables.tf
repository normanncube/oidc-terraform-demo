variable "subnet_id" {
  description = "The ID of the subnet where EC2 instances will be launched"
  type        = string
}   

variable "vpc_id" {
  description = "The ID of the VPC where security groups will be created"
  type        = string
}