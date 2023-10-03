#!/bin/bash

sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y make python3-venv
git clone https://github.com/prabodh1194/ray_snowflake
cd ray_snowflake
make all
