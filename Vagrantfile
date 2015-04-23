# -*- mode: ruby -*-
# vi: set ft=ruby :

module OS
    def OS.windows?
        (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM) != nil
    end

    def OS.mac?
        (/darwin/ =~ RUBY_PLATFORM) != nil
    end

    def OS.unix?
        !OS.windows?
    end

    def OS.linux?
        OS.unix? and not OS.mac?
    end
end

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "digio/webdev"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false
  config.vm.box_url = "webserver.box"

  config.ssh.private_key_path = "tools/ssh-keys/vagrant"

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  Dir[File.expand_path('tools/fowarded_ports/*.rb', File.dirname(__FILE__))].each do |fowardedfile|
    eval(IO.read(fowardedfile), binding)
  end 
  

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"
  if OS.windows?
    config.vm.network "private_network", type: "dhcp"
  else
    config.vm.network "private_network", ip: "192.168.33.10"
  end

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # Create files with the shares into tools/shares/shares.rb
  # Example for content
  # virtualmachine share:
  # config.vm.synced_folder "c:/www", "/www"
  # NFS share:
  # config.vm.synced_folder "c:/www", "/www", type: "nfs"

  Dir[File.expand_path('tools/shares/*.rb', File.dirname(__FILE__))].each do |shares|
    eval(IO.read(shares), binding)
  end  

  if OS.windows?
    config.winnfsd.uid = 1
    config.winnfsd.gid = 1
  end

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
     vb.memory = "1024"
     #vb.memory = 2048
     vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
     vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]

     if OS.mac
      cpus = `sysctl -n hw.ncpu`.to_i
     elseif OS.linux
      cpus = `nproc`.to_i
     else
      cpus = 2
     end

     v.customize ["modifyvm", :id, "--cpus", cpus]
  end
  
  # View the documentation for the provider you are using for more
  # information on available options.

  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
 
  config.vm.provision :shell, path: "tools/provisioning/provisioning.sh"

  # Run this script when the virtual machine is working
  config.vm.provision :shell, path: "tools/provisioning/run_on_start.sh", run: "always", privileged: false
end
