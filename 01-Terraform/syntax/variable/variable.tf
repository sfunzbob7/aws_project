variable "number_example" {
	description = "An example of a number variable in Terraform"
	type				= number
	default			= 42
}

variable "security_group_name" {
	description = "The name of the security group"
	type				= string
	default			= "terraform-example-instance"
}

variable "list_example" {
	description = "An example of a list in Terraform"
	type				= list
	default			= ["a", "b", "c"]
}
