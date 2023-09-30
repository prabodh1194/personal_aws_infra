output "instance_public_ip" {
  value = aws_instance.ray_general_purpose_machine.public_ip
}
