install(PROGRAMS pibridge-shutdown
  DESTINATION ${CMAKE_INSTALL_SBINDIR}/
)

install(FILES pibridge-shutdown.8
  DESTINATION ${CMAKE_INSTALL_MANDIR}/man8/
)

install(FILES set-mac-functions
  DESTINATION ${CMAKE_INSTALL_DATADIR}/revpi/
)

install(PROGRAMS ks8851-set-mac lan95xx-set-mac
  DESTINATION ${CMAKE_INSTALL_SBINDIR}/
)

install(FILES ks8851-set-mac.8
  DESTINATION ${CMAKE_INSTALL_MANDIR}/man8/
)

set(XXD /usr/bin/xxd)
add_custom_target(
  lan9514.bin ALL
  COMMAND ${XXD} -r ${CMAKE_SOURCE_DIR}/tools/lan9514.hex ${PROJECT_BINARY_DIR}/tools/lan9514.bin
  DEPENDS ${XXD} ${CMAKE_SOURCE_DIR}/tools/lan9514.hex
)

install(FILES ${PROJECT_BINARY_DIR}/tools/lan9514.bin
  DESTINATION ${CMAKE_INSTALL_DATADIR}/revpi
)
