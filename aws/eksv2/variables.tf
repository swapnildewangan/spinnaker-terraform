## VPC CIDR Block ##

variable "vpc_cidr" {
  default     = "10.0.0.0/16"
  description = "VPC_cidr block"
  type        = string
}

## CIDR Block 1, for demo-spinnaker-public-us-east-1a Subnet ##

variable "demo-spinnaker-public-us-east-1a-cidr" {
  default     = "10.0.1.0/24"
  description = "demo-spinnaker-public-us-east-1a_subnet1"
  type        = string
}

## CIDR Block 2, for demo-spinnaker-public-us-east-1b Subnet ##

variable "demo-spinnaker-public-us-east-1b-cidr" {
  default     = "10.0.2.0/24"
  description = "demo-spinnaker-public-us-east-1b_subnet2"
  type        = string
}

## CIDR Block 3, for demo-spinnaker-public-us-east-1c Subnet ##

variable "demo-spinnaker-public-us-east-1c-cidr" {
  default     = "10.0.3.0/24"
  description = "demo-spinnaker-public-us-east-1c_subnet3"
  type        = string
}

## CIDR Block 4, for demo-spinnaker-private-us-east-1a Subnet ##

variable "demo-spinnaker-private-us-east-1a-cidr" {
  default     = "10.0.4.0/24"
  description = "private_app_subnet1"
  type        = string
}

## CIDR Block 5, for demo-spinnaker-private-us-east-1a Subnet ##

variable "demo-spinnaker-private-us-east-1b-cidr" {
  default     = "10.0.5.0/24"
  description = "private_app_subnet2"
  type        = string
}

## CIDR Block 6, for demo-spinnaker-private-us-east-1a Subnet ##

 variable "demo-spinnaker-private-us-east-1c-cidr" {
   default     = "10.0.6.0/24"
   description = "private_app_subnet3"
   type        = string
 }

## DB CIDR Block 1 ##

variable "private-database-subnet-1-cidr" {
  default     = "10.0.5.0/24"
  description = "private_db_subnet1"
  type        = string
}

## DB CIDR Block 2 ##

variable "private-database-subnet-2-cidr" {
  default     = "10.0.6.0/24"
  description = "private_db_subnet2"
  type        = string
}


## DB Instance    ##

variable "database-instance-class" {
  default     = "db.t3.micro"
  description = "The Database Instance type"
  type        = string
}

##  multi_AZ   ##

variable "multi-az-deployment" {
  default     = false
  description = "Create a Standby DB Instance"
  type        = bool
}

## DB Username ##

variable "username" {
  default = "user01"
  type = string
}

## DB Password ##

variable "password" {
  default = "password01"
  type = string
}
