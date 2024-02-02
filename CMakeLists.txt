# SPDX-License-Identifier: GPL-2.0-or-later
#
# SPDX-FileCopyrightText: 2022-2023 KUNBUS GmbH

cmake_minimum_required(VERSION 3.13)

project(revpi-tools LANGUAGES C)

include(GNUInstallDirs)

add_subdirectory(examples-watchdog)
add_subdirectory(firstboot)
add_subdirectory(revpi-config)
add_subdirectory(revpi-factory-reset)
add_subdirectory(systemd)
add_subdirectory(tools)
add_subdirectory(udev)
