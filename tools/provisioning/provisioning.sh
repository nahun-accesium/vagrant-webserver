<<<<<<< HEAD:tools/provisioning/provisioning.sh
#!/bin/bash
echo "Enabling default ssh key..."
cat /vagrant/tools/provisioning/vagrant.pub > /home/vagrant/.ssh/authorized_keys
echo "Copying bashrc config..."
cat /vagrant/tools/provisioning/bashrc >> /home/vagrant/.bashrc
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
=======
#!/bin/bash
echo "Enabling default ssh key..."
sudo cat /vagrant/tools/vagrant.pub > /home/vagrant/.ssh/authorized_keys
echo "Copying bashrc config..."
sudo cat /vagrant/tools/bashrc >> /home/vagrant/.bashrc
echo "Updating timezone..."
sudo echo \"Europe/Madrid\" | sudo tee /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata
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
>>>>>>> e17a8d94f468e2de90f1fb5d1dab8886641cc905:tools/provisioning.sh
sudo npm install -g bower