revpi-config(1)

; SPDX-License-Identifier: GPL-2.0-or-later

; SPDX-FileCopyrightText: 2016-2025 KUNBUS GmbH

# NAME

revpi-config - enable and disable features on a RevPi

# SYNOPSIS

*revpi-config* *enable* _feature_++
*revpi-config* *disable* _feature_++
*revpi-config* *status* _feature_++
*revpi-config* *available* _feature_++
*revpi-config* *availstat* _feature_++
*revpi-config* *set* _feature_ _value_
*revpi-config* *get* _feature_

# DESCRIPTION

*revpi-config* allows enabling and disabling specific settings in
/boot/firmware/config.txt as well as systemd services on a RevPi. It also allows
querying the status (whether enabled) and availability (whether installed) of
each feature and will convey the result on standard output (1 or 0).

The availability and status of a feature can also be queried simultaneously
using the *availstat* command. The return value is 2 if the feature is not
available, 1 if the feature is available and enabled and 0 if the feature is
available but not enabled.

Revolution Pi is a set of IoT products based on the Raspberry Pi and geared
towards industrial usage.

# SUPPORTED FEATURES

## gui

Boot to the graphical desktop versus the text console. (Default is the
text console.)

## revpi-con-can

Enable CON CAN device tree overlay for the RevPi Connect. (Default is
disabled.)

## var-log.mount

Store logs on a tmpfs-backed directory to reduce eMMC wear and free up disk
space. Requires a reboot! Logs will always be empty after a reboot, so the
ability to debug crashes is lost. The total size of the directory is capped at
50 MByte. It is recommended to disable swap as well because tmpfs is swappable.
(Default is to not use a tmpfs but store logs directly on the eMMC.)

## dphys-swapfile

Use swap. Disabling it reduces eMMC wear and frees up disk space. (Default is
disabled.)

## teamviewer-revpi

Start TeamViewer remote access service. (Default is disabled.)

## pimodbus-master

Start Revolution Pi Modbus master. (Default is disabled.)

## pimodbus-slave

Start Revolution Pi Modbus slave. (Default is disabled.)

## systemd-timesyncd

Start NTP daemon. If there is no Internet connectivity, no GPS/DCF77 receiver
and no NTP server on the LAN, it is recommendable to disable it. This avoids
continuous polling of the \*.debian.pool.ntp.org servers and error messages
caused by their unreachability. (Default is enabled.)

## ssh

Start SSH daemon. By disabling it, remote login is prevented and the attack
surface thus reduced. (Default is enabled.)

## logi-rts

Start logi.RTS PLC runtime system. (Default is disabled.)

## nodered

Start Node-RED runtime system. (Default is disabled.)

## noderedrevpinodes-server

Start daemon to bridge between Node-RED and piControl. (Default is disabled.)

## revpipyload

Start daemon to load and monitor a RevPiModIO application, serve the piControl
process image to RevPiNetIO, serve a configuration GUI and publish IO values via
MQTT. (Default is disabled.)

## avahi

Avahi is a system which facilitates service discovery on a local network via the
mDNS/DNS-SD protocol. This enables you to plug your computer into a network and
instantly be able to view other Revolution Pi's (this is also branded as
"Bonjour" and sometimes "Zeroconf").

## bluetooth

Enable built-in Bluetooth interface using rfkill(8). (Default is enabled.)

## ieee80211

Enable built-in WLAN interface using rfkill(8). (Default is enabled.)

## external-antenna

Controls the use of the external antenna on a Revolution Pi with CM4 module.
After activating this option, the external antenna is used. When this option is
deactivated, the CM4 module falls back to the internal antenna by default.

## wifi-country

Set or get the WiFi country code for the device. The country code must be a valid
ISO 3166-1 alpha-2 code.

# SEE ALSO

For more information on Revolution Pi visit https://revolutionpi.com
