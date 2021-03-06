# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "boxcutter/ubuntu1604"
  config.vm.network "private_network", ip: "192.168.33.11"
  # config.vm.network "public_network", bridge: "en0: Wi-Fi (AirPort)"

  config.vm.synced_folder ".", "/vagrant"
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
    vb.cpus = "2"
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
    apt-get install -y python-pip devscripts debhelper ruby ruby-dev ruby-compass git iptables-persistent python-dev libffi-dev libssl-dev vim
    pip install --upgrade pip
    pip install ansible markupsafe

    gem install fpm
  SHELL

  config.vm.provision :ansible_local do |ansible|
    ansible.playbook = "kapture.yml"
    ansible.sudo = true

    ansible.host_vars = {
      "default" => {
        "systemname"           => "kapture-vagrant",
        "vagrant"              => true,
        "kapture_app_branch"   => "unstable",
        "reboots_during_run"   => false
      }
    }
  end


  # dev tools, needed in case you wanna do dev
  config.vm.provision "shell", inline: <<-DEVSHELL
    npm install -g grunt-cli npm bower
  DEVSHELL

  # notify user it's all good.'
  config.vm.provision "shell", inline: "echo System built successfully.  Connect to http://kapture-vagrant.local/ to use."
end
