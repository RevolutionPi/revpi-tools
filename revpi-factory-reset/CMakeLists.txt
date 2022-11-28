install(FILES revpi-functions
  DESTINATION /usr/share/revpi)

install(PROGRAMS revpi-factory-reset
  DESTINATION sbin
)

install(FILES revpi-factory-reset.sh
  DESTINATION /etc/profile.d)

install(FILES revpi-factory-reset.8
  DESTINATION share/man/man8
)
