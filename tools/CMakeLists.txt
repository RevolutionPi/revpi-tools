# SPDX-License-Identifier: GPL-2.0-or-later
#
# SPDX-FileCopyrightText: 2022-2024 KUNBUS GmbH

install(PROGRAMS lan743x-set-mac lan78xx-set-mac lan95xx-set-mac ks8851-set-mac revpi-set-mac
  DESTINATION ${CMAKE_INSTALL_SBINDIR}/
)

set(MAN_PAGES_8 ks8851-set-mac.8 lan743x-set-mac.8 lan78xx-set-mac.8 lan95xx-set-mac.8 revpi-set-mac.8)

foreach(man_page IN LISTS MAN_PAGES_8)
  add_custom_target(
    ${man_page} ALL
    COMMAND scdoc < ${CMAKE_SOURCE_DIR}/tools/${man_page}.scd > ${PROJECT_BINARY_DIR}/${man_page}
    DEPENDS ${CMAKE_SOURCE_DIR}/tools/${man_page}.scd
  )

  install(FILES ${PROJECT_BINARY_DIR}/${man_page}
    DESTINATION ${CMAKE_INSTALL_MANDIR}/man8/
  )
endforeach()

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

install(FILES
  ${PROJECT_BINARY_DIR}/tools/lan9514.bin
  ${PROJECT_BINARY_DIR}/tools/lan7800.bin
  ${PROJECT_BINARY_DIR}/tools/lan743x.bin
  DESTINATION ${CMAKE_INSTALL_DATADIR}/revpi
)

# vim:et sw=2
