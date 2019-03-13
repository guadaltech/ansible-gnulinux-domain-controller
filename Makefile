
up:
	#export VAGRANTFILE_API_VERSION="2"
	#export VAGRANT_DISABLE_VBOXSYMLINKCREATE=1
	vboxmanage list vms
	vagrant up

destroy:
	rm -rf .vagrant/provisioners/ansible/inventory && vagrant destroy -f
	rm -rf .vagrant/
	rm -rf ubuntu-*

ansible:
	ssh-keygen -f "/home/jmtorres/.ssh/known_hosts" -R [127.0.0.1]:2222
	ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i inventory/local/hosts.ini --become --become-user=root ansible.yml -vvv --limit all

deploy: up ansible

upgrade_vagrant:
	rm -rf .vagrant/provisioners/ansible/inventory
	./tools/upgrade_vagrant.bash
	rm -rf *.deb && rm -rf *.deb\.*

