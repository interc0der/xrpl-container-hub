#!/bin/bash

docker -v
if [ $? -ne 0 ]; then
    echo "Installing docker"
    sudo apt-get -y update
    sudo apt-get -y install ca-certificates curl gnupg lsb-release jq
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get -y update
    sudo apt-get -y install docker-ce docker-ce-cli containerd.io
fi    

# compose
docker-compose --version
if [ $? -ne 0 ]; then
    echo "Installing docker-compose"
    sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
fi

# openssl
openssl version
if [[ $? -ne 0 ]]; then
    echo "Installing openssl"
    sudo apt-get -y install openssl
fi

# jq
jq --version
if [[ $? -ne 0 ]]; then
    echo "Installing jq"
    sudo apt-get -y install jq
fi

echo "Installation finished."