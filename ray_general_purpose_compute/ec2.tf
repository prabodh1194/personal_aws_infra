resource "aws_instance" "ray_general_purpose_machine" {
    ami           = var.architecture == "x86_64" ? "ami-053b0d53c279acc90" : "ami-0a0c8eebcdd6dcbd0"
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
