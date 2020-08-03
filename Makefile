SHELL:=/bin/bash
#INVENTORY_DIR:=inventory
INVENTORY_DIR:=inventory-blk

vagrant_up:
	#export VAGRANTFILE_API_VERSION="2"
	#export VAGRANT_DISABLE_VBOXSYMLINKCREATE=1
	vboxmanage list vms
	vagrant up

vagrant_destroy:
	rm -rf ~/.ssh/known_hosts
	rm -rf .vagrant/provisioners/ansible/${INVENTORY_DIR} && vagrant destroy -f
	rm -rf .vagrant/
	rm -rf ubuntu-*

domain:
	source tools/generated_domain.sh

install: domain
	echo "" > .create_hosts.sh
	echo "[INFO] Using dir ${INVENTORY_DIR}"
	sed -i 's/_setup: false/_setup: true/' ${INVENTORY_DIR}/local/group_vars/all/all.yml
	sed -i 's/_uninstall: true/_uninstall: false/' ${INVENTORY_DIR}/local/group_vars/all/all.yml
	ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ${INVENTORY_DIR}/local/hosts.ini --become --become-user=root ansible.yml --extra-vars "$(shell cat tools/build_variable_domain)" -v --limit all

uninstall: domain
	echo "[INFO] Using dir ${INVENTORY_DIR}"
	sed -i 's/_setup: true/_setup: false/' ${INVENTORY_DIR}/local/group_vars/all/all.yml
	sed -i 's/_uninstall: false/_uninstall: true/' ${INVENTORY_DIR}/local/group_vars/all/all.yml
	ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ${INVENTORY_DIR}/local/hosts.ini --become --become-user=root ansible.yml --extra-vars "$(shell cat tools/build_variable_domain)" -v --limit all

vagrant_deploy: vagrant_up install

vagrant_upgrade:
	rm -rf .vagrant/provisioners/ansible/${INVENTORY_DIR}
	./tools/upgrade_vagrant.bash
	rm -rf *.deb && rm -rf *.deb\.*
