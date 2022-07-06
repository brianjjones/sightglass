#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi
# Install OpenVINO
wget https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB
sudo apt-key add GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB
echo "deb https://apt.repos.intel.com/openvino/2021 all main" | sudo tee /etc/apt/sources.list.d/intel-openvino-2021.list
sudo apt update
apt install intel-openvino-runtime-ubuntu20-2021.4.752 -y
source /opt/intel/openvino_2021/bin/setupvars.sh
ln -s /opt/intel/openvino_2021 /opt/intel/openvino
