# -*- mode: ruby -*-
# vi: set ft=ruby :

# Source: https://github.com/kubernetes-sigs/kubespray

SUPPORTED_OS = {
  "ubuntu_xenial"       => {box: "ubuntu/xenial64", user: "vagrant"},
  "ubuntu_bionic"       => {box: "ubuntu/bionic64", user: "vagrant"},
  "ubuntu1604"          => {box: "generic/ubuntu1604", user: "vagrant"},
  "ubuntu1804"          => {box: "generic/ubuntu1804", user: "vagrant"},
}

# Instances variables
$num_instances = 2
$instance_name_prefix = "node"
$os = "ubuntu_xenial"
$vm_cpus = 1
$vm_memory = 1024
$vm_gui = false
$exec_ansible = false
$subnet_private = "10.45.10"
$subnet_public = "10.80.1"
$bridge = "enp2s0f1"

# Ansible
# node-$service_x_instance
bind9_instance = 1
ldap_instance = 1
kerberos_instance = 1
sssd_instance = 2

$playbook = "ansible.yml"
host_vars = {}
$inventory = "inventory/local" if ! $inventory
$inventory = File.absolute_path($inventory, File.dirname(__FILE__))
if ! File.exist?(File.join(File.dirname($inventory), "hosts.ini"))
  $vagrant_ansible = File.join(File.dirname(__FILE__), ".vagrant", "provisioners", "ansible")
  FileUtils.mkdir_p($vagrant_ansible) if ! File.exist?($vagrant_ansible)
  if ! File.exist?(File.join($vagrant_ansible,"inventory"))
    FileUtils.ln_s($inventory, File.join($vagrant_ansible,"inventory"))
  end
end

$box = SUPPORTED_OS[$os][:box]
Vagrant.configure(2) do |config|

  config.vm.box = $box
  if SUPPORTED_OS[$os].has_key? :box_url
    config.vm.box_url = SUPPORTED_OS[$os][:box_url]
  end
  config.ssh.username = SUPPORTED_OS[$os][:user]

  if Vagrant.has_plugin?("vagrant-vbguest") then
    config.vbguest.auto_update = false
  end

  config.ssh.insert_key = false

  (1..$num_instances).each do |i|
     config.vm.define vm_name = "%s-%01d" % [$instance_name_prefix, i] do |node|
      node.vm.hostname = vm_name

      node.vm.provider :virtualbox do |vb|
        vb.memory = $vm_memory
        vb.cpus = $vm_cpus
        vb.gui = $vm_gui
        vb.linked_clone = false
      end

      ip_private = "#{$subnet_private}.#{i+100}"
      ip_public = "#{$subnet_public}.#{i+100}"
      node.vm.post_up_message = "Public: #{ip_public} - Private: #{ip_private}"
      #node.vm.network :private_network, ip: ip_private, auto_config: false
      node.vm.network :private_network, ip: ip_private
      #node.vm.network :public_network, ip: ip_public, bridge: $bridge

      config.vm.provision "shell",
        inline: "sudo apt-get install -y python"

      host_vars[vm_name] = {
        "ip": ip_public
      }

      if i == $num_instances and $exec_ansible
        node.vm.provision "ansible" do |ansible|
          ansible.playbook = $playbook
          $ansible_inventory_path = File.join( $inventory, "hosts.ini")
          if File.exist?($ansible_inventory_path)
            config.vm.post_up_message = "Inventory file exist: #{$ansible_inventory_path}"
            ansible.inventory_path = $ansible_inventory_path
          else
            config.vm.post_up_message = "Inventory file not exist: #{$ansible_inventory_path}"
          end
          ansible.verbose = true
          ansible.become = true
          ansible.limit = "all"
          ansible.host_key_checking = false
          ansible.host_vars = host_vars
          ansible.groups = {
            "bind9" => ["#{$instance_name_prefix}-#{$bind9_instance}"],
            "ldap" => ["#{$instance_name_prefix}-#{$ldap_instance}"],
            "kerberos" => ["#{$instance_name_prefix}-#{$kerberos_instance}"],
            "sssd" => ["#{$instance_name_prefix}-#{$sssd_instance}"],
          }
          # Start ansible.yaml with arguments
          #ansible.raw_arguments = ["--forks=#{$num_instances}", "--flush-cache", "-vvv"]
        end
      end

    end
  end
  
end
