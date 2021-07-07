terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.39.0"
    }


resource "random_pet" "bucket_name" {
  length    = 5
  separator = "-"
  prefix    = "learning"
}

module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = random_pet.bucket_name.id
  force_destroy = true
  acl    = "private"
}

resource "random_pet" "object_names" {
  count = 5

  length    = 4
  separator = "_"
  prefix    = "learning"
}

resource "aws_s3_bucket_object" "objects" {
  count = 4

  acl          = "public-read"
  key          = "${random_pet.object_names[count.index].id}.txt"
  bucket       = module.s3_bucket.s3_bucket_id
  #content      = "Example object #${count.index}"
  content       = "Bucket object #${count.index}"
  content_type = "text/plain"
}
