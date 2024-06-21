# SPDX-FileCopyrightText: 2024 KUNBUS GmbH
#
# SPDX-License-Identifier: GPL-2.0-or-later

# lightly based on
# https://gitlab.alpinelinux.org/alpine/alpine-conf/-/blob/master/tests/test_env.sh

init_env() {
	export MOCK=echo ROOT=$PWD/
	export PATH="$(atf_get_srcdir)"/../firstboot:"$PATH"
}
