#INIT Variables

variables {
  global_var_org = "swiftline"
  global_bu = "IT"
} 

# Validate if the variables are correct
run "validate_inputs" {
  command = plan

  variables {
    instance_name = "demo"
    instance_type = "t2micro"
    region_name   = "us-east-1"
  } 

  expect_failures = [
    var.instance_name,
    var.instance_type
  ]
}


# Validate if the name of the instance is correct
run "name_validation"{
  command = plan

  assert {
    condition = module.ec2.ec2_instance_tags["Name"] == "demo" #demo-us-east-1
    error_message = "Instance name is not as expected"
  }
}

run "name_validation_apply"{
  command = apply

  assert {
    condition = module.ec2.ec2_instance_tags["Name"] == "${var.instance_name}-${var.region_name}"
    error_message = "Instance name is not as expected"
  }
}



# Validate if the organization tag is correct
run "org_validation"{
  command = plan


  assert {
    condition = module.ec2.ec2_instance_tags["Organization"] == var.global_var_org
    error_message = "Instance Organization is not as expected"
  }
}

# Validate if the business unit tag is correct
run "bu_validation"{
  command = plan

  assert {
    condition = module.ec2.ec2_instance_tags["Business_Unit"] == var.global_bu
    error_message = "BU is not as expected"
  }
}

provider "aws" {
  alias  = "america"
  region = "us-east-1"
}

# Validate if the instance is in the correct region
run "customised_provider_america" {

  command = plan

  providers = {
    aws = aws.america
  }

  assert {
    condition = module.ec2.ec2_instance_tags["Name"] == "${var.instance_name}-us-east-1"
    error_message = "Instance name is not as expected"
  }
}

# Validate if the instance region switch works
provider "aws" {
  alias  = "london"
  region = "eu-west-2"
}

run "customised_provider_london" {

  command = plan

  providers = {
    aws = aws.london
  }

  assert {
    condition = module.ec2.ec2_instance_tags["Name"] == "${var.instance_name}-eu-west-2"
    error_message = "Instance name is not as expected"
  }
}


# Integration

run "create_key_pair" {
  module {
    source = "./tests/key"
  }
}

# Validate if the key pair name is the same
run "lookup_verify_key_pair" {

  module {
    source = "./tests/lookup"
  }

  assert {
    condition     = data.aws_key_pair.this.key_name == var.keypair_name
    error_message = "Key pair name is wrong"
  }
}

# Validate if the keypair is assigned to the DEMO
run "check_name_validation_call" {      
  assert {
    condition = run.name_validation.ec2_created_for== "DEMO"
    error_message = "Created for is wrong"
  }
}