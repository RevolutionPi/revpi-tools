install(FILES 50-revpi.rules
  DESTINATION ${CMAKE_INSTALL_LIBDIR}/udev/rules.d
)

install(PROGRAMS revpi_mac
  DESTINATION ${CMAKE_INSTALL_LIBDIR}/udev
)
