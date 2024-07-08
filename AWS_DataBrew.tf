resource "aws_databrew_dataset" "madhatter_databrew_dataset" {
  name = "madhatter_databrew_dataset"
  input {
    s3_input_definition {
      bucket = aws_s3_bucket.raw_data_bucket.bucket
    }
  }
}

resource "aws_databrew_project" "madhatter_databrew_project" {
  name         = "madhatter_databrew_project"
  dataset_name = aws_databrew_dataset.madhatter_databrew_dataset.name
  role_arn     = aws_iam_role.datapipeline_role.arn
}
