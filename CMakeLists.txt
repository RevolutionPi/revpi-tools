cmake_minimum_required(VERSION 3.13)

project(revpi-tools)

add_subdirectory(examples-watchdog)
add_subdirectory(udev)
add_subdirectory(systemd)
add_subdirectory(revpi-sos)

install(PROGRAMS pibridge-shutdown	revpi_buster_upgrade_fix_nodered.sh	revpi_buster_fix_pictory.sh revpi_buster_fixup_pkgs.py
  DESTINATION /usr/sbin
)

