install(PROGRAMS pibridge-shutdown
  DESTINATION /usr/sbin
)

install(FILES pibridge-shutdown.8
  DESTINATION share/man/man8
)

install(PROGRAMS ks8851-set-mac lan95xx-set-mac
  DESTINATION sbin
)

install(FILES ks8851-set-mac.8
  DESTINATION share/man/man8
)

add_custom_target(lan9514.bin ALL
  COMMAND xxd -r lan9514.hex lan9514.bin
  DEPENDS /usr/bin/xxd
  WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/tools
  VERBATIM)

install(FILES lan9514.bin
  DESTINATION /usr/share/revpi)
