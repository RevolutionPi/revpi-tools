# SPDX-License-Identifier: GPL-2.0-or-later
#
# SPDX-FileCopyrightText: 2023 KUNBUS GmbH

install(PROGRAMS revpi-config
  DESTINATION ${CMAKE_INSTALL_BINDIR}/
)

set(MAN_PAGE_1 revpi-config.1)

add_custom_target(
  ${MAN_PAGE_1} ALL
  COMMAND scdoc < ${CMAKE_SOURCE_DIR}/revpi-config/${MAN_PAGE_1}.scd > ${PROJECT_BINARY_DIR}/${MAN_PAGE_1}
  DEPENDS ${CMAKE_SOURCE_DIR}/revpi-config/${MAN_PAGE_1}.scd
)

install(FILES ${PROJECT_BINARY_DIR}/${MAN_PAGE_1}
  DESTINATION ${CMAKE_INSTALL_MANDIR}/man1/
)
