data "aws_ami" "ray_general_purpose_machine" {
    most_recent = true
    owners      = ["amazon"]
    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }

    filter {
        name   = "architecture"
        values = [var.architecture]
    }

    filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu*"]
    }
}

resource "aws_instance" "ray_general_purpose_machine" {
    ami           = data.aws_ami.ray_general_purpose_machine.id
    instance_type = var.instance_type
    user_data_replace_on_change = true

    user_data = base64encode("$(file(setup_ray.sh))")
    instance_market_options {
        market_type = "spot"
        spot_options {
            spot_instance_type = "persistent"
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
