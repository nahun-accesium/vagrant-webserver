#!/bin/bash
echo "Updating timezone..."
echo \"Europe/Madrid\" | sudo tee /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata
echo "Updating package information..."
sudo apt-get update --fix-missing
echo "Downloading Composer"
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
sudo chmod +x /usr/local/bin/composer
echo "Downloading Deployer"
wget http://deployer.org/deployer.phar
sudo mv deployer.phar /usr/local/bin/dep
sudo chmod +x /usr/local/bin/dep
echo "Installing Bower"
sudo npm install -g bower