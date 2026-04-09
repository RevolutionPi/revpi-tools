# SPDX-License-Identifier: GPL-2.0-or-later
#
# SPDX-FileCopyrightText: 2026 KUNBUS GmbH

set(copy_files
	chpasswd
	dtoverlay
	getent
	id
	piSerial
)

foreach(file IN LISTS copy_files)
	configure_file(${file} ${file} COPYONLY)
endforeach()
