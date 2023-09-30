data "aws_ami" "ray_general_purpose_machine" {
    most_recent = true
    owners      = ["amazon"]
    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }

    filter {
        name   = "architecture"
        values = ["arm64"]
    }

    filter {
        name   = "name"
        values = ["amzn2-ami-kernel-*"]
    }
}

resource "aws_instance" "ray_general_purpose_machine" {
    ami           = data.aws_ami.ray_general_purpose_machine.id
    instance_type = "r7gd.2xlarge"

    instance_market_options {
        market_type = "spot"
        spot_options {
            max_price = "0.5"
        }
    }

    security_groups = [
        aws_security_group.ssh_sg.name
    ]

    tags = {
        Name = "ray_general_purpose_machine"
    }
}
