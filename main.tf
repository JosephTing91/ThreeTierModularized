
module "iam" {
  source="./iam"
}

module "vpc" {
  source="./vpc"
}

module "sgs" {
  source="./sgs"
  vpc_id= module.vpc.vpc_id
}

module "db" {
  source="./db"
  dbsg_id = module.sgs.dbsg_id
  privsubnet3_id= module.vpc.privsubnet3_id
  privsubnet4_id= module.vpc.privsubnet4_id  
}
module "lb" {
  source="./lb"
  vpc_id= module.vpc.vpc_id
  publbsg_id= module.sgs.publbsg_id
  privlbsg_id= module.sgs.privlbsg_id
  pubsubnet1_id= module.vpc.pubsubnet1_id
  pubsubnet2_id= module.vpc.pubsubnet2_id
  privsubnet1_id= module.vpc.privsubnet1_id
  privsubnet2_id= module.vpc.privsubnet2_id
}

module "s3" {
  source="./s3"
}

module "ec2" {
  source="./ec2"
  instance_profile_name= module.iam.instance_profile
  bastionsg_id= module.sgs.bastionsg_id
  webinstancesg_id= module.sgs.webinstancesg_id
  appinstancesg_id= module.sgs.appinstancesg_id
  pubsubnet1_id=module.vpc.pubsubnet1_id
  pubsubnet2_id=module.vpc.pubsubnet2_id
  privsubnet1_id=module.vpc.privsubnet1_id
  privsubnet2_id=module.vpc.privsubnet2_id

  private-lb-tg-arn=module.lb.private-lb-tg-arn
  public-lb-tg-arn=module.lb.public-lb-tg-arn

}


provider "aws" {
  region="us-east-1"
}

