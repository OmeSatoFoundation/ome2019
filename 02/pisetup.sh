#!/bin/bash

echo "Setup HSP3 and Gimp for Raspberry Pi"
cd ~/ome/bin
sudo cp hsed.png /usr/share/pixmaps/
sudo cp hsed.desktop /usr/share/applications/
lxpanelctl restart
cd ~/ome/03/archives
sudo cp * /var/cache/apt/archives
sudo apt-get update
sudo apt -y install gimp
cd ~/ome/03
