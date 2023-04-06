install(PROGRAMS revpi-sos
  DESTINATION ${CMAKE_INSTALL_BINDIR}/
)

install(FILES revpi.py
  DESTINATION ${CMAKE_INSTALL_DATADIR}/sosreport/sos/plugins/
)

install(FILES revpi-sos.1
  DESTINATION ${CMAKE_INSTALL_MANDIR}/man1/
)
