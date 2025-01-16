revpi-factory-reset(8)

# NAME

*revpi-factory-reset* - initialise a Revolution Pi system

# SYNOPSIS

*revpi-factory-reset*++
*revpi-factory-reset* _core|connect|connect-se|flat|compact_ _serial_nr_ _mac_address_

# DESCRIPTION

The script *revpi-factory-reset* initialises a Revolution Pi system. Unlike the
name suggests it does *not* reset the system and its data. All files that are
read or written to are listed in the *FILES* section. Initialising the system
encompasses the following tasks:

- configuring the device tree overlay
- resetting the default password of the user _pi_ *if the user exists*
- setting the hostname
- setting the MAC address of the Ethernet interfaces

The first form, without arguments, can be used when a HAT EEPROM is present, as
it already contains all the information that would otherwise be required from
the user.++
A HAT EEPROM is present on a device if the file _/proc/device-tree/hat/custom_1_
exists on the system.

The second form, with arguments, gives the parameters with which the system is
configured. This includes the type of Revolution Pi (one out of _core_,
_connect_, _connect-se_, _flat_, and _compact_), the serial number of the
system, and the MAC address of the first Ethernet interface.++
Figuring out the required information is documented in section *FINDING REQUIRED
INFORMATION*.

The default hostname prefix for the hostname is _RevPi_. If this should be
changed to something else the file _/usr/share/revpi/hostname_ can be filled
with the content being only the desired prefix on the first line of the file.

# FINDING REQUIRED INFORMATION

The required information for using *revpi-factory-reset* without a HAT EEPROM is
the following:

- device type
- serial number
- MAC address

The device type is printed on the front plate of the device, usually at the top
(e.g. _RevPi Connect 5_).

The serial number is printed on the front plate towards the bottom, next to a
data matrix. It is the number in the middle of the 3 numbers listed.

The MAC address is printed on the front plate in the middle and is sometimes
labelled as "MAC ADD". Only the first address listed here is required.

# EXIT STATUS

*revpi-factory-reset* returns _0_ on success and _1_ when an error occurs.

# FILES

- _/proc/device-tree/hat/custom_1_
- _/boot/firmware/config.txt_
- _/boot/firmware/dt-blob.bin_
- _/dev/tpm0_
- _/usr/share/revpi/hostname_
- _/etc/shadow_
- _/etc/hosts_
- _/etc/hostname_
- _/etc/revpi/factory-reset_

# EXAMPLES

Initialise a _RevPi Connect 5_ (equipped with a HAT EEPROM):

```
# revpi-factory-reset
```

Initialise a _RevPi Connect_ with the serial number _8149_ and the MAC
address _C8:3E:A7:01:01:82_:

```
# revpi-factory-reset connect 8149 C8:3E:A7:01:01:82
```

# SEE ALSO

*piSerial*(8), *revpi-set-mac*(8), *dtoverlay*(1), *chpasswd*(8), *hostname*(1)

For more information on Revolution Pi visit _https://revolutionpi.com_
