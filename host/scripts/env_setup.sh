#!/bin/bash
# Colors
RD='\033[0;31m' # Red
GR='\033[0;32m' # Green
BL='\033[0;34m' # Blue
NC='\033[0m'    # No Color

# Path
ENV_NAME='covisart'

clear

printf "${BL}[i](COVISART) Install the newest version of Protobuf 3.7 ${NC}\n"

wget https://github.com/protocolbuffers/protobuf/releases/download/v3.7.1/protoc-3.7.1-linux-x86_64.zip
sudo apt install unzip

unzip protoc-3.7.1-linux-x86_64.zip -d protoc3
sudo mv protoc3/bin/* /usr/local/bin/
sudo mv protoc3/include/* /usr/local/include/

rm -r protoc*

printf "${BL}[i](COVISART) Setting up virtual environment '${ENV_NAME}':${NC}\n"

printf "${BL}[i](COVISART)Installing Python and Required Commands/${ENV_NAME}:${NC}\n"
sudo apt-get install -y python-pip python-dev python-virtualenv

# -- Environment --
printf "${BL}[i](COVISART)(1/3) Setting up environment in ~/${ENV_NAME}:${NC}\n"

mkdir ~/${ENV_NAME}
virtualenv ~/${ENV_NAME}
# Activate
source ~/${ENV_NAME}/bin/activate

# -- Requirements --

printf "${BL}[i] (2/3) Installing requirements:${NC}\n"
if [ -e requirements.txt ]
then
    pip install -r requirements.txt
else
    printf "${RD}[!] Requirements not installed: File not found.${NC}\n"
fi

# -- Object Detection API (TensorFlow) --
printf "${BL}[i] (3/3) Downloading TF Object Detection API:${NC}\n"
mkdir tmp
git clone https://github.com/tensorflow/models ./tmp/models
cp -r tmp/models/research/object_detection/* src/detector/object_detection/
rm -r tmp

printf "${BL}[i] Compiling Protobuf Libraries\n"
cd src/detector
sudo protoc object_detection/protos/*.proto --python_out=.
cd ../..

# -- Info --
printf "${BL}[i] Activate virtual environment:\n"
printf "${GR}    source ~/${ENV_NAME}/bin/activate${NC}\n"
printf "${BL}[i] Deactivate virtual environment:${NC}\n"
printf "${GR}    deactivate${NC}\n"
source ~/${ENV_NAME}/bin/activate
printf "${GR} python tracking-app.py ${NC}\n"