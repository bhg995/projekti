#!/bin/bash
set -e

apt-get update
apt-get upgrade
apt-get install -y salt-master salt-minion

cp -r salt /srv/salt
cp top.sls /srv/salt/top.sls

systemctl enable salt-master
systemctl start salt-master
