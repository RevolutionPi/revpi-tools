install(FILES firstboot.service
  DESTINATION /lib/systemd/system/
)

install(FILES resize-fs.sh
  DESTINATION ${CMAKE_INSTALL_DATADIR}/revpi/firstboot/
)
