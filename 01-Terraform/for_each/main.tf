provider "aws" {
  region = "ap-northeast-2"
}

resource "aws_iam_user" "example" {
	for_each = toset(var.user_names)
	name		 = each.value
}

variable "user_names" {
	description = "Create IAM users with these names"
	type				= list(string)
	default			= ["aws02-neo", "aws02-trinity", "aws02-morpheus"]
}

output "all_user" {
	value 			= values(aws_iam_user.example)[*].arn
	description = "The Name for all users"
}
