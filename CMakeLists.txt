cmake_minimum_required(VERSION 3.13)

project(revpi-tools)

include(GNUInstallDirs)

add_subdirectory(avahi-service)
add_subdirectory(examples-watchdog)
add_subdirectory(udev)
add_subdirectory(systemd)
add_subdirectory(revpi-sos)
add_subdirectory(fixup)
add_subdirectory(tools)
add_subdirectory(revpi-factory-reset)
