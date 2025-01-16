# SPDX-License-Identifier: GPL-2.0-or-later
#
# SPDX-FileCopyrightText: 2022-2024 KUNBUS GmbH

cmake_minimum_required(VERSION 3.13)

project(revpi-tools LANGUAGES C)

include(GNUInstallDirs)

option(ENABLE_TESTS "Build and enable running tests" OFF)

configure_file(Kyuafile Kyuafile COPYONLY)

add_subdirectory(examples-watchdog)
add_subdirectory(firstboot)
add_subdirectory(revpi-config)
add_subdirectory(revpi-factory-reset)
add_subdirectory(tools)

if(ENABLE_TESTS)
	enable_testing()

	find_program(kyua_exec NAMES kyua REQUIRED)
	find_program(atf_sh_exec NAMES atf-sh REQUIRED)
	add_test(
		NAME kyua
		COMMAND sh -c "kyua test --kyuafile Kyuafile --build-root ${CMAKE_CURRENT_BINARY_DIR}; \
			kyua report-junit --output report.xml"
	)
	add_subdirectory(tests)
endif(ENABLE_TESTS)
