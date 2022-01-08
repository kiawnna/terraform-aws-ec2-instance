# terraform-aws-ec2-instance
An opinionated module that creates an ec2 instance to be used as a bastion.

## Instantiation
The simplest instantiation requires only an `environment` and `ami_id`.

```
module "ec2" {
  source = "git@github.com:kiawnna/terraform-aws-ec2-instance.git"
  ami_id = "ami-id"
  environment = var.environment
}
```
> This example will create an ec2 instance without a key pair, with the defaults found below in Variables / Customizations.

---
To use this module as a bastion, you would need to add a `key_pair` and `subnet_id` as well. The below example also shows how you can
programmatically grab the ami id for an Amazon Linux 2 AMI.

```
data "aws_ami" "amazon-2" {
  most_recent = true

  filter {
    name = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }
  owners = ["amazon"]
}

module "bastion" {
  source = "git@github.com:kiawnna/terraform-aws-ec2-instance.git"
  ami_id = data.aws_ami.amazon-2.id
  key_pair = "my-key-pair.pem"
  environment = var.environment
  subnet_id = "subnet-id"
}
```
> This example will create an amazon linux 2 instance, type t2.micro in a subnet of your choice.


## Resources Created
* An EC2 instance.

## Outputs
The instance id.

Reference it as:

> module.ec2_instance_module_name.instance_id

## Variables / Customization
The variable below can be customized to fit your needs. The current defaults are:
>  * `instance_type` &rarr; t2.micro
>  * `associate_public_ip` &rarr; *true*
>  * `subnet_id` &rarr; none
>  * `key_pair` &rarr; none
>  * `security_group_ids` &rarr; none
>  * `environment` &rarr; none

See the `variables.tf` file for further information.

## Tags
Tags are automatically added to all resources where possible. Tags will have the following format:

```
tags = {
    Name = "${var.environment}-bastion"
    Deployment_Method = "terraform"
    Environment = var.environment
}
```

