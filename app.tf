# Creates AWS instances with Docker + the LN app

variable "count" {
  default = 2
}

resource "aws_instance" "app" {
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
  provisioner "remote-exec" {
    inline = [
      /*"sudo apt-get update",*/
      /*"sudo apt-get -y install docker.io",*/
      # Provide Rabbitmq IP to app
      "echo ${aws_instance.rabbitmq.public_ip} > rabbitmq_host",
      "cat rabbitmq_host",
      # Build container
      #"git pull repo"
      #"cd /opt/docker && sudo docker build -t app .",
      #"sudo docker run --name app -t -i app"
    ]
  }
}
