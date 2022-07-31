locals {
  common_tags={
    Owner = "Devops Team"
    cs= "joeksting@gmail.com"
    time=formatdate("DD MM YYYY hh:mn ZZZ", timestamp())
  }
  prod_tags={
    Owner = "Prod Team"
    cs= "joeksting@gmail.com"
    time=formatdate("DD MM YYYY hh:mn ZZZ", timestamp())
  }
  dev_tags={
    Owner = "Dev Team"
    cs= "joeksting@gmail.com"
    time=formatdate("DD MM YYYY hh:mn ZZZ", timestamp())
  }

}   


variable "key_name"{
    default= "ALB-KEY"
}

variable "region"{
  type   = string
  default = "us-east-1"
}

variable "ami_id_master" {
    type= string
    default = "ami-0a6656ad0aedd2886"

}

variable "ami_id_managed" {
  type = map(string)
  default = {
    "us-east-1" = "ami-0cff7528ff583bf9a"
    "us-east-2" = "ami-02d1e544b84bf7502"
    "us-west-1" = "ami-0d9858aa3c6322f73"    
    "us-west-2" = "ami-098e42ae54c764c35"
    "ca_central"= "ami-00f881f027a6d74a0"
  }
}
variable "instance_profile_name" {
} 
variable "bastionsg_id"{
}
variable "pubsubnet1_id"{
}
variable "pubsubnet2_id"{
}
variable "privsubnet1_id"{
}
variable "privsubnet2_id"{
}
variable "webinstancesg_id"{
}
variable "appinstancesg_id"{
}
variable "private-lb-tg-arn"{
}
variable "public-lb-tg-arn"{
}
