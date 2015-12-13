#!/bin/env ruby
# encoding: utf-8
# -*- mode: ruby -*-
# vi: set ft=ruby :

unless Vagrant.has_plugin?('vagrant-puppet-install') 
  raise "You must install the plugin 'vagrant-puppet-install' with the command: vagrant plugin install vagrant-puppet-install"
end

# If hostsupdater plugin is installed, add all server names as aliases.
unless Vagrant.has_plugin?('vagrant-librarian-puppet') 
  raise "You must install the plugin 'vagrant-librarian-puppet' with the command: vagrant plugin install vagrant-librarian-puppet"
end

# If hostsupdater plugin is installed, add all server names as aliases.
unless Vagrant.has_plugin?("vagrant-hostsupdater")
  raise "You must install the plugin 'vagrant-hostsupdater' with the command: vagrant plugin install vagrant-hostsupdater"
end

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

nodes = [  
  { :ip => '192.168.33.10', :box => 'ubuntu/trusty64', :ram => 512, :vhost => 'machine.new' }
]

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  nodes.each do |node|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.    

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = node[:box]  

  memory = node[:ram] ? node[:ram] : 1024;

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  config.vm.network :forwarded_port, guest: 80, host: 8088

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network :private_network, ip: node[:ip]

  config.vm.provision "shell", path: "script.sh"

  #=========================================================================
  #=========================================================================
  #=========== REQUIRED ======>  sudo visudo <===========================
  #=========================================================================
  #=========================================================================
  # Allow passwordless startup of Vagrant with vagrant-hostsupdater.
  #Cmnd_Alias VAGRANT_HOSTS_ADD = /bin/sh -c echo "*" >> /etc/hosts
  #Cmnd_Alias VAGRANT_HOSTS_REMOVE = /usr/bin/sed -i -e /*/ d /etc/hosts
  #%admin ALL=(root) NOPASSWD: VAGRANT_HOSTS_ADD, VAGRANT_HOSTS_REMOVE
  #=========================================================================
  #=========================================================================
  #=========================================================================
  #=========================================================================


  # If hostsupdater plugin is installed, add all server names as aliases.
  if Vagrant.has_plugin?("vagrant-hostsupdater")
    # Add all hosts that aren't defined as Ansible vars.
    config.hostsupdater.aliases = []
    config.hostsupdater.aliases.push(node[:vhost])
  end

  # Make puppet avail inside machine
  #config.vm.provision "puppet"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.provider :virtualbox do |vb|
  #   # Don't boot with headless mode
  #  vb.gui = true
  #
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
  #   # Use VBoxManage to customize the VM. For example to change memory:
    vb.customize ["modifyvm", :id, "--memory", memory.to_s]
  end

  config.vm.synced_folder "angularJs", "/var/www/html", id: "vagrant-root"

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "puppet/manifests"    
    puppet.manifest_file = "site.pp"    
    puppet.module_path = "puppet/modules"
  end
  end
end