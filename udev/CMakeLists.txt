# SPDX-License-Identifier: GPL-2.0-or-later
#
# SPDX-FileCopyrightText: 2022-2023 KUNBUS GmbH

include(FindPkgConfig)
pkg_check_modules(UDEV REQUIRED "udev")
pkg_get_variable(UDEV_UDEVDIR "udev" "udevdir")

install(FILES 50-revpi.rules
  DESTINATION ${UDEV_UDEVDIR}/rules.d
)

install(PROGRAMS revpi_mac
  DESTINATION ${UDEV_UDEVDIR}
)
