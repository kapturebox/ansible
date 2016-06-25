# -*- mode: ruby -*-
# vi: set ft=ruby :

disk = '/tmp/kapture-vagrant-storage.vdi'

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"
  # config.vm.box_check_update = false
  config.vm.network "private_network", ip: "192.168.33.11"
  # config.vm.network "public_network", bridge: "en0: Wi-Fi (AirPort)"

  config.vm.synced_folder ".", "/vagrant"
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
    vb.cpus = "2"

    unless File.exist?(disk)
      vb.customize ['createhd', '--filename', disk, '--size', 1 * 1024]
    end
    vb.customize ['storageattach', :id, '--storagectl', 'SATAController', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', disk]
  end


  config.vm.provision "shell", inline: <<-SHELL
    set -e

    # xenial has some more invasive apt cron jobs that start on boot ..
    while ! apt-get update >/dev/null 2>&1; do
      echo 'waiting for apt lock to clear, then performing apt-get update ..'
      sleep 5
    done;

    # install some tools for development on vagrant box, and ansible
    export DEBIAN_FRONTEND=noninteractive
    apt-get install -y python-pip devscripts debhelper ruby ruby-dev git iptables-persistent python-dev libffi-dev libssl-dev
    pip install --upgrade setuptools
    pip install ansible markupsafe

    gem install fpm

    # get rest of machine setup for kapture
    # export ANSIBLE_CONFIG=/vagrant/ansible.cfg
  SHELL

  config.vm.provision :ansible_local do |ansible|
    ansible.playbook = "initial-setup.yml"
    ansible.sudo = true

    ansible.host_vars = {
      "default" => {
        "systemname" => "vagrant-kapture",
        "vagrant" => true,
        "storage_block_device" => "/dev/sdb"
      }
    }
  end
end