variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet1_cidr_blocks" {
  description = "CIDR blocks for public subnets"

  default     = "10.0.1.0/28"
}

variable "public_subnet2_cidr_blocks" {
  description = "CIDR blocks for public subnets"
  
  default     = "10.0.3.0/28"
}

variable "private_subnet1_cidr_blocks" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.0.4.0/23", "10.0.10.0/23"]
}

variable "private_subnet2_cidr_blocks" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
  default     = [ "10.0.14.0/23","10.0.20.0/23"]
}

variable "rds_private_subnet1_cidr_blocks" {
  description = "CIDR blocks for private subnets"
  type        = string
  default     = "10.0.25.0/27"
}

variable "rds_private_subnet2_cidr_blocks" {
  description = "CIDR blocks for private subnets"
  type        = string
  default     = "10.0.30.0/27"
}

variable "availability_zones" {
  description = "Availability zones"
  type        = list(string)
  default     = ["us-west-2a", "us-west-2c"]
}

variable "rds_group" {
   type        = list(string)
  default     = ["10.0.25.0/27","10.0.30.0/27",]
  
}



# ec2 module inputs
variable "instance_type" {
  description = "The type of the instance"
  default = "t2.micro"
}

variable "ami" {
  description = "The AMI to use for the instance"
  default = "ami-0c65adc9a5c1b5d7c"
}


# rds variables
variable "allocated_storage" {
  description = "The amount of storage to allocate to the database (in GB)"
  type        = number
  default     = 10
}

variable "db_name" {
  description = "The name of the database"
  type        = string
  default     = "mydb"
}

variable "engine" {
  description = "The database engine type"
  type        = string
  default     = "mysql"
}

variable "engine_version" {
  description = "The database engine version"
  type        = string
  default     = "5.7"
}

variable "instance_class" {
  description = "The RDS instance type"
  type        = string
  default     = "db.t3.micro"
}

variable "username" {
  description = "The master username for the database"
  type        = string
  default     = "foo"
}

variable "password" {
  description = "The master password for the database"
  type        = string
  default     = "foobarbaz"
}

variable "parameter_group_name" {
  description = "The name of the parameter group to associate with the database"
  type        = string
  default     = "default.mysql5.7"
}

variable "skip_final_snapshot" {
  description = "Whether to skip the creation of a final snapshot when the database instance is deleted"
  type        = bool
  default     = true
}

variable "name" {
  description = "project name"
  default = "Ventura"
}

variable "keypair" {
  type = string
  default = "oregion-keypair"
}

locals {
  skip_final_snapshot = true

  common_tags={
    Owner = "Ventura Devops Team"
    cs = "jjetchgroup2@gmail.com.co"
    time = formatdate("DD MMM YYYY hh:mm ZZZ", timestamp())
  }

}