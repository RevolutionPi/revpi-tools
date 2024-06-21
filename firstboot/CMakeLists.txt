# SPDX-License-Identifier: GPL-2.0-or-later
#
# SPDX-FileCopyrightText: 2023-2024 KUNBUS GmbH

include(FindPkgConfig)
pkg_check_modules(SYSTEMD REQUIRED "systemd")
pkg_get_variable(SYSTEMD_SYSTEMUNITDIR "systemd" "systemdsystemunitdir")

install(FILES firstboot.service
  DESTINATION ${SYSTEMD_SYSTEMUNITDIR}
)

install(FILES regenerate-ssh-host-keys.service
  DESTINATION ${SYSTEMD_SYSTEMUNITDIR}
)

install(PROGRAMS resize-fs.sh
  DESTINATION ${CMAKE_INSTALL_DATADIR}/revpi/firstboot/
)
