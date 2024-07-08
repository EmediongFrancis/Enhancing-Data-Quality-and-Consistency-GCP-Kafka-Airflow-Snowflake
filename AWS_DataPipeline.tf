resource "aws_datapipeline_pipeline" "data_movement_pipeline" {
  name        = "madhatter_data_movement_pipeline"
  description = "Pipeline for moving data between S3 buckets"
  role_arn    = aws_iam_role.datapipeline_role.arn

  parameter_objects {
    id = "myS3InputLocation"
    attributes {
      key   = "type"
      value = "AWS::S3::ObjectKey"
    }
    attributes {
      key   = "description"
      value = "The S3 input location"
    }
  }

  pipeline_objects = [
    {
      id   = "Default"
      name = "Default"
      fields = [
        {
          key   = "scheduleType"
          value = "cron"
        },
        {
          key   = "failureAndRerunMode"
          value = "CASCADE"
        },
        {
          key   = "pipelineLogUri"
          value = "s3://${aws_s3_bucket.raw_data_bucket.bucket}/logs"
        }
      ]
    }
  ]
}

# IAM Role for DataPipeline
resource "aws_iam_role" "datapipeline_role" {
  name = "datapipeline_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "datapipeline.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "datapipeline_policy" {
  role       = aws_iam_role.datapipeline_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSDataPipelineRole"
}
