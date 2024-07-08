resource "aws_redshift_cluster" "madhatter_redshift_cluster" {
  cluster_identifier = "madhatter-redshift-cluster"
  node_type          = "dc2.large"
  master_username    = "masteruser"
  master_password    = "MasterUserPassword123"
  cluster_type       = "multi-node"
  number_of_nodes    = 2
  iam_roles          = [aws_iam_role.datapipeline_role.arn]
}

resource "aws_redshift_subnet_group" "madhatter_subnet_group" {
  name       = "madhatter-subnet-group"
  subnet_ids = ["subnet-12345abcde", "subnet-67890fghij"]
}

resource "aws_security_group" "madhatter_redshift_sg" {
  name_prefix = "madhatter-redshift-sg-"

  ingress {
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
