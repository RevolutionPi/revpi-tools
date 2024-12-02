# SPDX-License-Identifier: GPL-2.0-or-later
#
# SPDX-FileCopyrightText: 2022-2024 KUNBUS GmbH

set(DATADIR ${CMAKE_INSTALL_FULL_DATADIR})

configure_file(
  revpi-set-mac.in
  revpi-set-mac
  FILE_PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE
  @ONLY
)

install(PROGRAMS
  lan743x-set-mac lan78xx-set-mac lan95xx-set-mac ks8851-set-mac ${CMAKE_CURRENT_BINARY_DIR}/revpi-set-mac
  DESTINATION ${CMAKE_INSTALL_SBINDIR}/
)

set(MAN_PAGES_8 ks8851-set-mac.8 lan743x-set-mac.8 lan78xx-set-mac.8 lan95xx-set-mac.8 revpi-set-mac.8)

foreach(man_page IN LISTS MAN_PAGES_8)
  add_custom_target(
    ${man_page} ALL
    COMMAND scdoc < ${CMAKE_CURRENT_SOURCE_DIR}/${man_page}.scd > ${CMAKE_CURRENT_BINARY_DIR}/${man_page}
    DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/${man_page}.scd
  )

  install(FILES ${CMAKE_CURRENT_BINARY_DIR}/${man_page}
    DESTINATION ${CMAKE_INSTALL_MANDIR}/man8/
  )
endforeach()

set(EEPROM_FILES lan9514 lan7800 lan743x)
find_program(XXD NAMES xxd REQUIRED)

foreach(file IN LISTS EEPROM_FILES)
  add_custom_target(
    ${file}.bin ALL
    COMMAND ${XXD} -r ${CMAKE_CURRENT_SOURCE_DIR}/${file}.hex ${CMAKE_CURRENT_BINARY_DIR}/${file}.bin
    DEPENDS ${XXD} ${CMAKE_CURRENT_SOURCE_DIR}/${file}.hex
  )

  install(FILES
    ${CMAKE_CURRENT_BINARY_DIR}/${file}.bin
    DESTINATION ${CMAKE_INSTALL_DATADIR}/revpi
  )
endforeach()

# vim:et sw=2
