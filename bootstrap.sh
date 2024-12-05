
#!/bin/bash
set -e

echo "Updating the system and installing Salt..."
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y salt-common wireguard qrencode

echo "Setting up Salt States..."
sudo mkdir -p /srv/salt
sudo cp -r salt/* /srv/salt/

echo "Applying Salt States..."
sudo salt-call --local state.apply
