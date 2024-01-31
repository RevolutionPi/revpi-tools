# SPDX-License-Identifier: GPL-2.0-or-later
#
# SPDX-FileCopyrightText: 2023 KUNBUS GmbH

install(PROGRAMS revpi-config
  DESTINATION ${CMAKE_INSTALL_BINDIR}/
)

install(FILES revpi-config.1
  DESTINATION ${CMAKE_INSTALL_MANDIR}/man1/
)
