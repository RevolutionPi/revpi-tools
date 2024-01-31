# SPDX-License-Identifier: GPL-2.0-or-later
#
# SPDX-FileCopyrightText: 2022-2023 KUNBUS GmbH

install(FILES revpi-functions
  DESTINATION ${CMAKE_INSTALL_DATADIR}/revpi/
)

install(PROGRAMS revpi-factory-reset
  DESTINATION ${CMAKE_INSTALL_SBINDIR}/
)

install(FILES revpi-factory-reset.sh
  DESTINATION ${CMAKE_INSTALL_SYSCONFDIR}/profile.d/
)

install(FILES revpi-factory-reset.8
  DESTINATION ${CMAKE_INSTALL_MANDIR}/man8/
)
