include(FindPkgConfig)
pkg_check_modules(SYSTEMD REQUIRED "systemd")
pkg_get_variable(SYSTEMD_SYSTEMUNITDIR "systemd" "systemdsystemunitdir")

install(FILES firstboot.service
  DESTINATION ${SYSTEMD_SYSTEMUNITDIR}
)

install(PROGRAMS resize-fs.sh
  DESTINATION ${CMAKE_INSTALL_DATADIR}/revpi/firstboot/
)
