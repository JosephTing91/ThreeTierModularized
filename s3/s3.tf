#create s3 bucket

resource "aws_s3_bucket" "bucket1" {
  bucket =   "ahjoebucket220730"
  
  tags = {
        Name        = "My bucket"
        Environment = "Dev"
    }
}
