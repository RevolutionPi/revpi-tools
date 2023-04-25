#!/bin/bash
#
# SPDX-License-Identifier: GPL-2.0
# Copyright: 2023 KUNBUS GmbH
#
# This script will run with the firstboot.service
# at the very first boot of the system.
#
# The resize of the root partition will be performed.
#
# The eMMC has 3.9 GByte on RevPis equipped with a CM1 or CM3, but those
# equipped with a CM3+ may have 7.8, 15.6 or 31.2 GByte.  Original RevPi images
# fit the 3.9 GByte eMMC.  If the eMMC is larger, "resize-fs.sh"
# resizes the last partition to the maximum available on the eMMC. Normally
# the last partition is the root partition but users are free to create
# custom images for the CM3+ with an additional data partition at the end.
# The filesystem on the last partition is expected to be ext4 and will be
# resized as well.

dev=mmcblk0
total_size="$(/bin/cat /sys/block/$dev/size)"
last_part="$(cd /dev || exit 1 ; /bin/ls ${dev}p* | /usr/bin/tail -1)"
last_part_start="$(/bin/cat "/sys/block/$dev/$last_part/start")"
last_part_size="$(/bin/cat "/sys/block/$dev/$last_part/size")"
last_part_max="$(("$total_size" - "$last_part_start"))"
if [ "$last_part_size" -lt "$last_part_max" ] ; then
	/usr/sbin/parted "/dev/$dev" resizepart 2 $((total_size-1))s
	/sbin/partprobe "/dev/$dev"
	/sbin/resize2fs "/dev/$last_part"
fi
