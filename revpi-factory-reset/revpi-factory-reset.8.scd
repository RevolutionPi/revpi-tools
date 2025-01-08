revpi-factory-reset(8)

# NAME

revpi-factory-reset - reset device tree overlay, password, machine-id, hostname,
FQDN and MAC address

# SYNOPSIS

*revpi-factory-reset* _<compact|connect|core>_ _<serial>_ _<mac address>_

# DESCRIPTION

*revpi-factory-reset* resets the product-specific device tree overlay,++
\- the password of user _pi_,++
\- the machine-id (128-bit hex string in _/etc/machine-id_),++
\- the hostname (e.g. _RevPi256_),++
\- the FQDN (e.g. _abcde12345.co.revolutionpi.de_) and++
\- the MAC address of each network interface (e.g. _c8:3e:a7:00:00:00_) to
factory defaults.

The password, machine-id and FQDN are automatically computed from the serial
number stored on the RevPi's Atmel CryptoAuth chip.

The serial number used for the hostname and the MAC address are lasered on the
RevPi's front plate and need to be supplied as arguments to
*revpi-factory-reset*. The MAC address is allowed to contain numbers, upper or
lower case characters and dashes or colons as byte separators. On RevPis with
more than one network interface, only a single MAC address needs to be
specified. The other MAC addresses are computed automatically since they are
consecutive.

Revolution Pi is a set of IoT products based on the Raspberry Pi and geared
towards industrial usage.

# SEE ALSO

For more information on Revolution Pi visit _https://revolutionpi.kunbus.com_
