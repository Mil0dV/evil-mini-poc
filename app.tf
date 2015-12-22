# Creates AWS instances with Docker + the LN app

variable "count" {
  default = 2
}

resource "aws_instance" "ln-app" {
  ami = "${var.app-ami}"
  instance_type = "t2.micro"
  count = "${var.count}"
  subnet_id = "${aws_subnet.public.id}"
  security_groups = ["${aws_security_group.default.id}"]
  key_name = "${aws_key_pair.deployer.key_name}"
  source_dest_check = false
  tags = {
    Name = "${format("app-%03d", count.index + 1)}"
  }
  connection {
    user = "ubuntu"
    key_file = "deploy-key"
  }
  provisioner "file" {
    source = "app/Dockerfile"
    destination = "/opt/ln-docker"
  }
  provisioner "remote-exec" {
    inline = [
      # Install docker
      "sudo apt-get update",
      "sudo apt-get -y install docker.io",
      # "curl -sSL https://get.docker.com/ubuntu/ | sudo sh",
      # Provide Redis IP to app
      "echo ${aws_instance.ln-redis.public_ip} > redis_host",
      "cat redis_host",
      # Build container
      "cd /opt/ln-docker && sudo docker build -t lame/app .",
      "sudo docker run --name ln-app -t -i lame/app"
    ]
  }
}
