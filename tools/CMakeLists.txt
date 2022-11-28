install(PROGRAMS pibridge-shutdown
  DESTINATION /usr/sbin
)

install(FILES pibridge-shutdown.8
  DESTINATION share/man/man8
)

install(PROGRAMS ks8851-set-mac
  DESTINATION sbin
)

install(FILES ks8851-set-mac.8
  DESTINATION share/man/man8
)
