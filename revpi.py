# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.


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
            ])

        pass
# vim: set et ts=4 sw=4 :
