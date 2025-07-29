# SPDX-FileCopyrightText: 2024-2025 KUNBUS GmbH
#
# SPDX-License-Identifier: GPL-2.0-or-later

# lightly based on
# https://gitlab.alpinelinux.org/alpine/alpine-conf/-/blob/master/tests/test_env.sh

init_env() {
	export MOCK=echo ROOT=$PWD/
	export PATH="$(atf_get_srcdir)"/../../tests/bin:"$(atf_get_srcdir)"/../revpi-factory-reset:"$(atf_get_srcdir)"/../firstboot:"$PATH"
	export DATADIR=usr/share
	export SYSCONFDIR=etc
}
