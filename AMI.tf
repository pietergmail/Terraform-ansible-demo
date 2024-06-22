data "aws_ami" "latest_ubuntu" {
  most_recent = true
  owners      = ["099720109477"]  # Canonical owner ID for Ubuntu AMIs

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

# outdated, tried to import image from bucket

/*data "aws_ami" "ubuntu_nginx_snapshot" {
  most_recent = true

  filter {
    name   = "name"
    values = "s3://terraform-bucket-r0745616/ami-083564a94ce90748e.bin"
  }
}

resource "aws_ami_copy" "ubuntu_nginx_php_ami" {
  name              = "Ubuntu nginx php"
  description       = "Simple AMI "
  source_ami_id     = data.aws_ami.ubuntu_nginx_snapshot.id
  source_ami_region = "your_aws_region"
}*/