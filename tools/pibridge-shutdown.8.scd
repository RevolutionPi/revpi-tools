pibridge-shutdown(8)

# NAME

pibridge-shutdown - shut down a PiBridge Ethernet interface if no gateway is attached

# SYNOPSIS

*pibridge-shutdown* <interface>

# DESCRIPTION

On the RevPi Core, the interrupt pin of the two PiBridge Ethernet interfaces
is not connected.  The interrupt must therefore be polled, which occupies
about 10% of one CPU core of a Compute Module 3. That's a waste of resources
if no gateway is attached. *pibridge-shutdown* therefore checks the carrier
state upon system boot and shuts the interface down if no carrier is detected.
It also tells dhcpcd to no longer manage the interface.

The issue is not present on the RevPi Connect, so PiBridge interfaces need
not be shut down on this product. *pibridge-shutdown* identifies affected
products by checking whether a valid interrupt is defined in the DeviceTree.

*pibridge-shutdown* is invoked by the systemd units *pileft-quirks.service* and
*piright-quirks.service*, which in turn are "wanted by" the systemd units
*pileft.device* and *piright.device* via appropriate udev rules in
*/lib/udev/rules.d/50-revpi.rules*.

# SEE ALSO

For more information on Revolution Pi visit https://revolutionpi.com
