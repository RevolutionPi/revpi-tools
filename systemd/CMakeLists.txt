# SPDX-License-Identifier: GPL-2.0-or-later
#
# SPDX-FileCopyrightText: 2022-2023 KUNBUS GmbH

include(FindPkgConfig)
pkg_check_modules(SYSTEMD REQUIRED "systemd")
pkg_get_variable(SYSTEMD_SYSTEMUNITDIR "systemd" "systemdsystemunitdir")

install(FILES pileft-quirks.service piright-quirks.service hdmi-disable.service
  DESTINATION ${SYSTEMD_SYSTEMUNITDIR}
)
