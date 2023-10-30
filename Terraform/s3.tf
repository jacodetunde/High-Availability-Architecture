resource "aws_s3_bucket" "bucket" {
  bucket = "ventura-prod-003"

  tags = {
    Name        = "Prod-bucket"
    Environment = "Prod"
  }
}