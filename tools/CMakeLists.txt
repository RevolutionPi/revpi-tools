# SPDX-License-Identifier: GPL-2.0-or-later
#
# SPDX-FileCopyrightText: 2022-2024 KUNBUS GmbH

install(PROGRAMS pibridge-shutdown
  DESTINATION ${CMAKE_INSTALL_SBINDIR}/
)

install(FILES pibridge-shutdown.8
  DESTINATION ${CMAKE_INSTALL_MANDIR}/man8/
)

install(FILES pibridge.conf
  DESTINATION ${CMAKE_INSTALL_SYSCONFDIR}/network/interfaces.d/
)

install(PROGRAMS lan743x-set-mac lan78xx-set-mac lan95xx-set-mac ks8851-set-mac revpi-set-mac
  DESTINATION ${CMAKE_INSTALL_SBINDIR}/
)

install(FILES ks8851-set-mac.8
  DESTINATION ${CMAKE_INSTALL_MANDIR}/man8/
)

set(XXD /usr/bin/xxd)
add_custom_target(
  lan9514.bin ALL
  COMMAND ${XXD} -r ${CMAKE_SOURCE_DIR}/tools/lan9514.hex ${PROJECT_BINARY_DIR}/tools/lan9514.bin
  DEPENDS ${XXD} ${CMAKE_SOURCE_DIR}/tools/lan9514.hex
)

add_custom_target(
  lan7800.bin ALL
  COMMAND ${XXD} -r ${CMAKE_SOURCE_DIR}/tools/lan7800.hex ${PROJECT_BINARY_DIR}/tools/lan7800.bin
  DEPENDS ${XXD} ${CMAKE_SOURCE_DIR}/tools/lan7800.hex
)

add_custom_target(
  lan743x.bin ALL
  COMMAND ${XXD} -r ${CMAKE_SOURCE_DIR}/tools/lan743x.hex ${PROJECT_BINARY_DIR}/tools/lan743x.bin
  DEPENDS ${XXD} ${CMAKE_SOURCE_DIR}/tools/lan743x.hex
)

install(FILES ${PROJECT_BINARY_DIR}/tools/lan9514.bin ${PROJECT_BINARY_DIR}/tools/lan7800.bin
  DESTINATION ${CMAKE_INSTALL_DATADIR}/revpi
)
