add_executable(patch_eeprom patch_eeprom.c)

target_link_libraries(patch_eeprom ftdi1)

install(TARGETS patch_eeprom
  DESTINATION /home/pi/connect
)

install(FILES README patch_eeprom.c enable_relay_watchdog.py disable_relay_watchdog.py revpi-connect-watchdog.sh
  DESTINATION /home/pi/connect
)

