sudo apt-get remove --auto-remove vagrant
rm -r ~/.vagrant.d
# Get latest version
VAGRANT_LATEST_VERSION=$(curl https://releases.hashicorp.com/vagrant/ | egrep -o "vagrant_[0-9]\.[0-9]\.[0-9]" | sort -V | tail -n -1 | cut -d "_" -f 2)
echo ${VAGRANT_LATEST_VERSION}
wget https://releases.hashicorp.com/vagrant/${VAGRANT_LATEST_VERSION}/vagrant_${VAGRANT_LATEST_VERSION}_x86_64.deb
sudo dpkg -i vagrant_${VAGRANT_LATEST_VERSION}_x86_64.deb
vagrant version
