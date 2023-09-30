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
    instance_type = "r7gd.xlarge"

    instance_market_options {
        market_type = "spot"
        spot_options {
            max_price = "0.5"
        }
    }

    tags = {
        Name = "ray_general_purpose_machine"
    }
}