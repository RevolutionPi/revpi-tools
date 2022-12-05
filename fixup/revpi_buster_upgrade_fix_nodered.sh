#!/bin/bash
#
# SPDX-License-Identifier: GPL-2.0
#
# Copyright 2021 KUNBUS GmbH
#

echo "############################################################################"
echo "After upgrading from Debian Stretch to Buster some packages of a Node-RED"
echo "installation have not been upgraded because their package version from"
echo "stretch-backports is higher than the package version in Buster."
echo "Node-RED might still work in Buster. However we recommend to fix the package"
echo "version issues."
echo "Before starting the script we strongly recommend to backup your Node-RED"
echo "projects as packages will be removed and reinstalled. Node-RED will be removed"
echo "completely. We recommend to use npm solely and installthe latest npm"
echo "and Node-RED directly and not through the Debian Repository."
echo "After package version fixing you will be asked if you wish to install Node-RED"
echo "immediately."
echo "############################################################################"

varfixit=""
while [ ! "$varfixit" = "y" -a ! "$varfixit" = "n" ] ; do
	read -p "Would you like to fix the package version issues now ? (y/n) : " varfixit
done
[ "$varfixit" = "n" ] && exit 0

echo "Starting fixing packages"
# fix package issues
python3 /usr/sbin/revpi_buster_fixup_pkgs.py
pkgfixrc=$?
if [ ! $pkgfixrc -eq 0 ] ; then
	echo "/usr/sbin/revpi_buster_fixup_pkgs.py returns with non-zero : $pkgfixrc"
	echo "Please check the output for errors"
	exit 1
fi
echo "Fixing packages successfully finished"

varfixit=""
while [ ! "$varfixit" = "y" -a ! "$varfixit" = "n" ] ; do
	read -p "Would you like to install the latest npm and Node-RED via script now ? (y/n) : " varfixit
done
[ "$varfixit" = "n" ] && exit 0

# install latest npm, NodeJS and Node-RED via script
NODEREDSCRIPT="/tmp/update-nodejs-and-nodered.sh"
curl -sL \
    https://raw.githubusercontent.com/node-red/linux-installers/master/deb/update-nodejs-and-nodered \
    --output "$NODEREDSCRIPT"
chmod 755 "$NODEREDSCRIPT"
sudo -u pi $NODEREDSCRIPT --confirm-install --confirm-pi
rm "$NODEREDSCRIPT"
# install Node-RED RevPi Nodes
npm install --prefix /home/pi/.node-red node-red-contrib-revpi-nodes
# install Node-RED RevPi-Nodes Server
sudo apt-get install -y noderedrevpinodes-server

