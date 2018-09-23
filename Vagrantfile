# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
    # Base VM OS configuration.
    config.vm.box = "geerlingguy/ubuntu1604"
    config.ssh.insert_key = false
    config.vm.synced_folder '.', '/vagrant', disabled: true
  
    # General VirtualBox VM configuration.
    config.vm.provider :virtualbox do |v|
      v.memory = 1024
      v.cpus = 2
      v.linked_clone = true
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--ioapic", "on"]
    end

    config.vm.define "stationeers" do |st|
      st.vm.hostname = "stationeers.test"
      st.vm.network :private_network, ip: "192.168.2.8"

      # Run Ansible provisioner once for all VMs at the end.
      st.vm.provision "ansible" do |ansible|
        ansible.compatibility_mode = "2.0"
        ansible.become = true
        ansible.version = "latest"
        ansible.playbook = "deploy.yml"
        ansible.inventory_path = "inventory"
        ansible.limit = "all"
        ansible.extra_vars = {
          ansible_ssh_user: 'vagrant',
          ansible_ssh_private_key_file: "~/.vagrant.d/insecure_private_key"
        }
      end   
    end 
  end
