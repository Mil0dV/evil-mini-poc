# Creates an AWS instance with Rabbitmq
resource "aws_instance" "rabbitmq" {
  ami = "${lookup(var.amis, var.region)}"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.public.id}"
  security_groups = ["${aws_security_group.default.id}"]
  key_name = "${aws_key_pair.deployer.key_name}"
  source_dest_check = false
  tags = {
    Name = "rabbitmq"
  }
  connection {
    user = "ubuntu"
    key_file = "deploy-key"
  }
  provisioner "remote-exec" {
    inline = [
      /* Install docker */
      "sudo apt-get update",
      /*"sudo apt-get -y install docker.io",*/
       /*"curl -sSL https://get.docker.com/ubuntu/ | sudo sh", */
      /* Initialize rabbitmq container */
      /*"sudo docker run --name rabbitmq rabbitmq"*/
    ]
  }
}
