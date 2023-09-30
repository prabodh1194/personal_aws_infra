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
        values = ["ubuntu/images/hvm-ssd/ubuntu*"]
    }
}

resource "aws_instance" "ray_general_purpose_machine" {
    ami           = data.aws_ami.ray_general_purpose_machine.id
    instance_type = "r7gd.2xlarge"

    instance_market_options {
        market_type = "spot"
        spot_options {
            spot_instance_type = "persistent"
            max_price = "0.5"
            instance_interruption_behavior = "stop"
        }
    }

    security_groups = [
        aws_security_group.ssh_sg.name
    ]

    tags = {
        Name = "ray_general_purpose_machine"
    }
}
