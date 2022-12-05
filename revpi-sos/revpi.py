#
# SPDX-License-Identifier: GPL-2.0
#
# Copyright 2020-2021 KUNBUS GmbH
#


from sos.plugins import Plugin, DebianPlugin

class RevPi(Plugin, DebianPlugin):
    """Revolution Pi Information
    """

    requires_root = True # with False, only the copy works
    profiles = ('system',)
    plugin_name = "revpi"

    def setup(self):
        self.add_copy_spec([
            "/var/log/messages",
            "/var/log/apache2/error.log",
            "/var/log/kern.log",
            "/var/log/daemon.log",
            "/etc/revpi/config.rsc",
            "/boot/cmdline.txt",
            "/boot/config.txt",
            "/etc/revpi/image-release",
            "/etc/dhcpcd.conf",
            "/etc/network/interfaces",
            "/etc/resolv.conf",
            "/etc/CODESYSControl.cfg",
            "/etc/CODESYSControl_User.cfg",
            "/tmp/codesyscontrol.log"
            ])

        self.add_cmd_output([
            "df -h",
            "dmesg",
            "uname -a",
            "piTest -d",
            "ps -ax",
            "ls /dev/ttyUSB*",
            "ls /dev/ttyRS485",
            "ls -l /etc/revpi/config.rsc",
            "vcgencmd measure_temp",
            "vcgencmd measure_clock arm",
            "lsusb -v",
            "free",
            "apt-cache show pictory",
            "apt-cache show revpi-webstatus",
            "apt-cache show raspberrypi-kernel",
            "netstat -ln",
            "vcgencmd version",
            "revpi-device-info",
            ])

        pass
# vim: set et ts=4 sw=4 :
