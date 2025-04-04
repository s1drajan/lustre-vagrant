
# -*- mode: ruby -*-
# vi: set ft=ruby :
#Vagrant.configure("2") do |config|
  # Use Ubuntu 18.04 base box
 # config.vm.box = "bionic64"

  # Optional: Assign a hostname
  #config.vm.hostname = "lustre-client"

  # Optional: Set memory/CPU resources
  #config.vm.provider "virtualbox" do |vb|
   # vb.memory = "2048"
    #vb.cpus = 2
  #end

  # Provision with the Lustre client install script
  #config.vm.provision "shell", path: "install_lustre_client.sh"
#end

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing
#
#cur_dir = File.dirname(File.expand_path(__FILE__))

#Vagrant.configure("2") do |config|
  
   # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.


  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a forwarded port mapping which allows access to a specific p  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"
  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machin


Vagrant.configure("2") do |config|
  config.vm.box = "almalinux/8"
  config.vm.hostname = "lustre-client"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
    vb.cpus = 2
  end

  # DNS fix to prevent curl errors
  config.vm.provision "shell", inline: <<-SHELL
    echo 'nameserver 8.8.8.8' > /etc/resolv.conf
  SHELL

  config.vm.provision "shell", path: "install_lustre_client.sh"
end

