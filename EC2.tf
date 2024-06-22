resource "aws_instance" "public_instance_1" {
  ami             = data.aws_ami.latest_ubuntu.id
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.public_subnet_1.id
  security_groups  = [aws_security_group.Security_group_terraform.id]
  key_name = aws_key_pair.generated_key.key_name
  associate_public_ip_address = true
  tags = { name ="public1"}
}

resource "aws_instance" "public_instance_2" {
  ami             = data.aws_ami.latest_ubuntu.id
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.public_subnet_2.id
  security_groups  = [aws_security_group.Security_group_terraform.id]
  key_name = aws_key_pair.generated_key.key_name
  associate_public_ip_address = true
  tags = { name ="public2"}
}

resource "aws_instance" "private_instance" {
  ami             = data.aws_ami.latest_ubuntu.id
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.private_subnet.id
  security_groups  = [aws_security_group.Security_group_terraform.id]
  key_name = aws_key_pair.generated_key.key_name
  tags = { name ="private"}
}

resource "local_file" "hosts" {
content = <<EOF
[all:vars]
ansible_user=ubuntu
ansible_connection=ssh
ansible_ssh_private_key_file=../terraform_key.pem

[webservers]
${aws_instance.public_instance_1.public_ip}
${aws_instance.public_instance_2.public_ip}

[database]
${aws_instance.private_instance.private_ip} ansible_ssh_common_args='-o ProxyCommand="ssh -q ubuntu@${aws_instance.public_instance_1.public_ip} -i ../terraform_key.pem -W %h:%p"'
EOF
filename = "ansible_project/hosts.ini"
}

resource "local_file" "connect" {
  content = <<EOF
  <!DOCTYPE html>
  <html>
  <head>
      <title>Server IP Address</title>
  </head>
  <body>
      <h1>Server IP Address</h1>

      <?php
          // Get the server's IP address
          $serverIp = $_SERVER['SERVER_ADDR'];

          // Display the IP address
          echo "<p>The server's IP address is: $serverIp</p>";


      ?>

      <?php

          $conn = new mysqli('${aws_instance.private_instance.private_ip}', 'test', 'test', 'testdb');

          if ($conn->connect_errno) {
          
              echo "Sorry, this website is experiencing problems.";


              echo "Error: Failed to make a MySQL connection, here is why: \n";
              echo "Errno: " . $conn->connect_errno . "\n";
              echo "Error: " . $conn->connect_error . "\n";

              exit;
          }
          else{
          	echo "Connection successful";
          }

      ?>
  </body>
  </html>
  EOF
  filename = "connect.php"
}