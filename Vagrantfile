# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "centos/7"
  config.vm.network "private_network", ip: "192.168.5.5"
  #config.vm.synced_folder ".", "/var/www/html",
    #owner: "vagrant",
    #group: "apache",
    #mount_options: ["dmode=775,fmode=664"]

  # Provider-specific configuration so you can fine-tune
  config.vm.provider "virtualbox" do |vb|
    # Display the VirtualBox GUI when booting the machine
    vb.gui = false
    vb.name = "My VM name"

    # Customize the cores number
    vb.cpus = "1"
    # Customize the amount of memory on the VM
    vb.memory = "512"
  end

  config.vm.provision "shell", path: "deploy.sh"
end
