data "aws_ami" "ray_general_purpose_machine" {
    most_recent = true
    owners      = ["amazon"]
    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }

    filter {
        name   = "architecture"
        values = ["x86_64"]
    }

    filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu*"]
    }
}

resource "aws_instance" "ray_general_purpose_machine" {
    ami           = data.aws_ami.ray_general_purpose_machine.id
    instance_type = "g5.4xlarge"


    security_groups = [
        aws_security_group.ssh_sg.name
    ]

    tags = {
        Name = "ray_general_purpose_machine"
    }
}
