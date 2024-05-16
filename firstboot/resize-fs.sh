#!/bin/bash
#
# SPDX-License-Identifier: GPL-2.0-or-later
#
# SPDX-FileCopyrightText: 2023-2024 KUNBUS GmbH
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

ROOT="/"

usage() {
	cat <<- __EOF__
	Usage: resize-fs.sh [-r ROOT]
	__EOF__

	exit "$1"
}

while getopts "r:" opt; do
	case $opt in
		r) ROOT="$OPTARG";;
		?) usage 1;;
	esac
done

dev=mmcblk0
total_size="$(cat "${ROOT}"sys/block/"$dev"/size)"
last_part="$(cd "${ROOT}"dev || exit 1 ; ls "${dev}"p* | tail -1)"
last_part_start="$(cat "${ROOT}"sys/block/"$dev"/"$last_part"/start)"
last_part_size="$(cat "${ROOT}"sys/block/"$dev"/"$last_part"/size)"
last_part_max="$(("$total_size" - "$last_part_start"))"
if [ "$last_part_size" -lt "$last_part_max" ] ; then
	${MOCK} parted "${ROOT}"dev/"$dev" resizepart 2 $((total_size-1))s
	${MOCK} partprobe "${ROOT}"dev/"$dev"
	${MOCK} resize2fs "${ROOT}"dev/"$last_part"
fi
