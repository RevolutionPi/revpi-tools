#!/bin/bash

# resize root partition
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
