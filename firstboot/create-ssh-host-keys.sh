#!/bin/sh
# SPDX-License-Identifier: BSD-2-Clause
#
# SPDX-FileCopyrightText: Matthew Vernon, Colin Watson
#
# These are functions from the opensh-server.postinst script to generate
# SSH server keys if they do not exist. We use the same logic as calling
# `dpkg-reconfigure opensh-server`, but we only limit ourselves to
# generating the key.
#
# Source: https://salsa.debian.org/ssh-team/openssh/-/blob/aec3fb034b67839761fd909d4b950cace95d513a/debian/openssh-server.postinst

default_keys() {
	# Create default keys, which was removed during image build
	echo /etc/ssh/ssh_host_rsa_key
	echo /etc/ssh/ssh_host_ecdsa_key
	echo /etc/ssh/ssh_host_ed25519_key
}

create_key() {
	msg="$1"
	shift
	hostkeys="$1"
	shift
	file="$1"
	shift

	if echo "$hostkeys" | grep -x "$file" >/dev/null && \
	   [ ! -f "$file" ] ; then
		printf %s "$msg"
		ssh-keygen -q -f "$file" -N '' "$@"
		echo
		if command -v restorecon >/dev/null 2>&1; then
			restorecon "$file" "$file.pub"
		fi
		ssh-keygen -l -f "$file.pub"
	fi
}

create_keys() {
	hostkeys="$(default_keys)"

	create_key "Creating SSH2 RSA key; this may take some time ..." \
		"$hostkeys" /etc/ssh/ssh_host_rsa_key -t rsa
	create_key "Creating SSH2 ECDSA key; this may take some time ..." \
		"$hostkeys" /etc/ssh/ssh_host_ecdsa_key -t ecdsa
	create_key "Creating SSH2 ED25519 key; this may take some time ..." \
		"$hostkeys" /etc/ssh/ssh_host_ed25519_key -t ed25519
}

create_keys
