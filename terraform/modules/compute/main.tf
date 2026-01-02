# Master Node
resource "aws_instance" "master" {
  count         = var.master_count
  ami           = var.ami_id        
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  vpc_security_group_ids = [var.security_group_id]

  user_data = <<-EOF
    #!/bin/bash
    useradd ${var.admin_username}
    echo "${var.admin_username}:${var.admin_password}" | chpasswd
    sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
    systemctl restart sshd

    yum install -y amazon-cloudwatch-agent
    /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl \
        -a fetch-config -m ec2 -c ssm:AmazonCloudWatch-linux -s
  EOF

  tags = {
    Name = "${var.org}-${var.environment}-${var.region}-master-${count.index + 1}"
    Role = "master"
  }
}

# Worker Node (similar)
resource "aws_instance" "worker" {
  count         = var.worker_count
  ami           = var.ami_id       # ✅ just use the variable
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  vpc_security_group_ids = [var.security_group_id]

  user_data = <<-EOF
    #!/bin/bash
    useradd ${var.admin_username}
    echo "${var.admin_username}:${var.admin_password}" | chpasswd
    sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
    systemctl restart sshd

    yum install -y amazon-cloudwatch-agent
    /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl \
        -a fetch-config -m ec2 -c ssm:AmazonCloudWatch-linux -s
  EOF

  tags = {
    Name = "${var.org}-${var.environment}-${var.region}-worker-${count.index + 1}"
    Role = "worker"
  }
}
