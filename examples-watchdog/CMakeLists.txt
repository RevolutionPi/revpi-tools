# SPDX-License-Identifier: GPL-2.0-or-later
#
# SPDX-FileCopyrightText: 2023-2024 KUNBUS GmbH

add_executable(patch_eeprom patch_eeprom.c)

target_link_libraries(patch_eeprom ftdi1)
include(GNUInstallDirs)

install(TARGETS patch_eeprom
  DESTINATION ${CMAKE_INSTALL_LIBDIR}/revpi-tools/
)

install(FILES README patch_eeprom.c enable_relay_watchdog.py disable_relay_watchdog.py revpi-connect-watchdog.sh
  DESTINATION ${CMAKE_INSTALL_DOCDIR}
)
