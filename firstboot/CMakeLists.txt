# SPDX-License-Identifier: GPL-2.0-or-later
#
# SPDX-FileCopyrightText: 2023-2025 KUNBUS GmbH

include(FindPkgConfig)
pkg_check_modules(SYSTEMD REQUIRED "systemd")
pkg_get_variable(SYSTEMD_SYSTEMUNITDIR "systemd" "systemdsystemunitdir")

configure_file(resize-fs.sh resize-fs.sh COPYONLY)

install(PROGRAMS resize-fs.sh
  DESTINATION ${CMAKE_INSTALL_DATADIR}/revpi/firstboot/
)

install(FILES revpi-firstboot-resize-fs.service
  DESTINATION ${SYSTEMD_SYSTEMUNITDIR}
)

install(PROGRAMS create-ssh-host-keys.sh
  DESTINATION ${CMAKE_INSTALL_DATADIR}/revpi/firstboot/
)

install(FILES revpi-firstboot-create-ssh-host-keys.service
  DESTINATION ${SYSTEMD_SYSTEMUNITDIR}
)
