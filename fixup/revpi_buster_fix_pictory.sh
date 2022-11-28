#!/bin/bash

[ ! $(id -u) -eq 0 ] && echo "Please run script with root rights!" && exit 0

echo "############################################################################"
echo "After upgrading from Debian Stretch to Buster PiCtory has moved from /var/www/"
echo "to /var/www/revpi. Therefore we need to move the configuration files to the"
echo "new location either. Otherwise your setup will not work anymore as default _config.rsc"
echo "is empty. This also applies to the credentials for the login to PiCtory and"
echo "Webstatus."
echo "############################################################################"

varfixit=""
while [ ! "$varfixit" = "y" ] && [ ! "$varfixit" = "n" ] ; do
	read -p "Would you like to fix PiCtory and Webstatus now ? (y/n) : " varfixit
done
[ "$varfixit" = "n" ] && exit 0

echo "Starting to migrate PiCtory and Webstatus"

# backup configuration directories of pictory and apache2 first
MIGDIR="/home/pi/migration"
PICMIGDIR="$MIGDIR/oldpictory"
APACHEMIGDIR="$MIGDIR/oldapache2"
mkdir -p "$PICMIGDIR" "$APACHEMIGDIR"
if [ ! -d "$PICMIGDIR" ] || [ ! -d "$APACHEMIGDIR" ] ; then
	echo "Could not create migration directories '$PICMIGDIR' and '$APACHEMIGDIR'"
	exit 1
fi
[ -d "/var/www/pictory/projects" ] && cp -r /var/www/pictory/projects $PICMIGDIR/.
[ -d "/var/www/pictory/export" ] && cp -r /var/www/pictory/export $PICMIGDIR/.
[ -d "/var/www/data" ] && cp -r /var/www/data $MIGDIR/.
[ -d "/etc/apache2" ] && cp -r /etc/apache2 $APACHEMIGDIR/.

# Remove apache2-bin and its dependant packages as well
apt-get -y --purge remove apache2-bin

# remove unnecessary and old packages, e.g. php-7.0
apt-get -y --purge autoremove
rm -rf /var/www/data
rm -rf /var/www/pictory

# install Apache2 and PiCtory again
apt-get -y install apache2 apache2-bin libapache2-mod-php pictory revpi-webstatus

# restore at least webstatus and PiCtory files
cp $PICMIGDIR/projects/* /var/www/revpi/pictory/projects/.
cp $PICMIGDIR/export/* /var/www/revpi/pictory/export/.
cp $MIGDIR/data/* /var/www/revpi/data/.

# restart Apache2 with the new configuration
systemctl restart apache2
piTest -x
echo "Migration of PiCtory and Webstatus successfully finished."
