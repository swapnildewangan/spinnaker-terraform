# main.tf
resource "aws_s3_bucket" "my_bucket" {
  bucket  = "hitachi-spinnaker-testing-bucket"
  tags    = {
	Name          = "MyS3Bucket"
	Environment    = "Production"
  }
}
