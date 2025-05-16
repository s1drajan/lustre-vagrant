Vagrant.configure("2") do |config|

  # ---------- CLIENT VM ----------
  config.vm.define "lustre-client" do |client|
    client.vm.box = "almalinux/8"
    client.vm.hostname = "lustre-client"
    client.vm.synced_folder ".", "/vagrant", disabled: true

    client.vm.provider "virtualbox" do |vb|
      vb.memory = 2048
      vb.cpus = 2
    end

    client.vm.provision "shell", path: "install_lustre_client.sh"
  end

  # ---------- SERVER VM ----------
  config.vm.define "lustre-server" do |server|
    server.vm.box = "almalinux/8"
    server.vm.hostname = "lustre-server"
    server.vm.synced_folder ".", "/vagrant", disabled: true

    server.vm.provider "virtualbox" do |vb|
      vb.memory = 4096
      vb.cpus = 2

      # Add 3 virtual disks for MGT, MDT, OST
      (1..3).each do |i|
        vb.customize ["createhd", "--filename", "disk#{i}.vdi", "--size", 1024]
        vb.customize ["storageattach", :id,
          "--storagectl", "SATA Controller",
          "--port", i,
          "--device", 0,
          "--type", "hdd",
          "--medium", "disk#{i}.vdi"]
      end

      # 👇 BIOS mode fix to disable EFI and use GRUB properly
      vb.customize ["modifyvm", :id, "--firmware", "bios"]
    end

    server.vm.provision "shell", path: "install_lustre_server.sh"
  end

end

