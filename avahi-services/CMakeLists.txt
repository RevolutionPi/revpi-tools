# SPDX-License-Identifier: GPL-2.0-or-later
#
# SPDX-FileCopyrightText: 2023 KUNBUS GmbH

install(FILES revpi-ssh.service
  DESTINATION ${CMAKE_INSTALL_SYSCONFDIR}/avahi/services
)
