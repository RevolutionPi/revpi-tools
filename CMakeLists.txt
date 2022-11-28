cmake_minimum_required(VERSION 3.13)

project(revpi-tools)

install(FILES README patch_eeprom patch_eeprom.c enable_relay_watchdog.py disable_relay_watchdog.py revpi-connect-watchdog.sh
  DESTINATION /home/pi/connect
)

install(PROGRAMS pibridge-shutdown	revpi_buster_upgrade_fix_nodered.sh	revpi_buster_fix_pictory.sh revpi_buster_fixup_pkgs.py
  DESTINATION /usr/sbin
)

install(PROGRAMS revpi-sos
  DESTINATION /usr/bin
)

install(FILES revpi.py
  DESTINATION /usr/share/sosreport/sos/plugins
)

install(FILES 50-revpi.rules
  DESTINATION /lib/udev/rules.d
)

install(FILES pileft-quirks.service piright-quirks.service
  DESTINATION /lib/systemd/system
)
