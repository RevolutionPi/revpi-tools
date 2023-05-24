include(FindPkgConfig)
pkg_check_modules(SYSTEMD REQUIRED "systemd")
pkg_get_variable(SYSTEMD_SYSTEMUNITDIR "systemd" "systemdsystemunitdir")

install(FILES pileft-quirks.service piright-quirks.service hdmi-disable.service
  DESTINATION ${SYSTEMD_SYSTEMUNITDIR}
)
