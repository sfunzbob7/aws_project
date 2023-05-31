provider "aws" {
  region = "ap-northeast-2"
}

resource "aws_iam_user" "example" {
	count = length(var.user_names)
	name 	= var.user_names[count.index]
}

variable "user_names" {
	description = "Create IAM users with these names"
	type				= list(string)
	default			= ["aws02_neo", "aws02_morpheus"]
}

output "neo_arn" {
	value 			= aws_iam_user.example[0].arn
	description = "The ARN for user neo"
}

output "all_arn" {
	value 			= aws_iam_user.example[*].arn
	description = "The ARN for all users"
}
