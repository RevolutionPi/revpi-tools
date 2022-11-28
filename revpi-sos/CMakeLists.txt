install(PROGRAMS revpi-sos
  DESTINATION /usr/bin
)

install(FILES revpi.py
  DESTINATION /usr/share/sosreport/sos/plugins
)

install(FILES revpi-sos.1
  DESTINATION share/man/man1
)
