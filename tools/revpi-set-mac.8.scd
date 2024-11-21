revpi-set-mac(8)

# NAME

revpi-set-mac - set non-volatile MAC address of Revolution Pi device

# SYNOPSIS

*revpi-set-mac* _eth\_interface_ _device\_type_ _mac\_address_

# Device types

The following device types are supported with *revpi-set-mac*:

- lan743x
- lan7800
- lan9514
- ks8851

# DESCRIPTION

*revpi-set-mac* sets the non-volatile MAC address of a Revolution Pi by writing
it to an attached EEPROM. The MAC address is allowed to contain numbers, upper
or lower case characters and dashes or colons as byte separators.

Revolution Pi is a set of IoT products based on the Raspberry Pi and
geared towards industrial usage.

# SEE ALSO

For more information on Revolution Pi visit https://revolutionpi.com
