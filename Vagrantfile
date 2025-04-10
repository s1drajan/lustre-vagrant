Vagrant.configure("2") do |config|
  # Use AlmaLinux 8 official box
  config.vm.box = "almalinux/8"
  config.vm.hostname = "lustre-client"

  # Disable the default synced folder to avoid VirtualBox Guest Additions issues
  config.vm.synced_folder ".", "/vagrant", disabled: true

  # Optional: set memory or CPU if needed
  config.vm.provider "virtualbox" do |vb|
    vb.memory = 2048
    vb.cpus = 2
  end

  # Provision the box using your custom script
  config.vm.provision "shell", path: "install_lustre_client.sh"
end

