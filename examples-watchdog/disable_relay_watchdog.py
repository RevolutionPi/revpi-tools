#!/usr/bin/env python3
#
# SPDX-License-Identifier: MIT
#
# Copyright: 2019 KUNBUS GmbH
#

# disable relay watchdog on RevPi Connect

import ftdi1 as ftdi
import os

def main():
    with open("/sys/bus/usb/devices/1-1.5.2/devnum", "r") as f:
        devnum = f.read()

    context = ftdi.new()
    if context == 0:
        print('new failed')
        os._exit(1)

    ret = ftdi.usb_open_string(context, "d:1/" + devnum)
    if ret != 0:
        print('open failed: %d' % ret)
        os._exit(1)

    # 0xf1 = all four CBUS pins are outputs, CBUS[0] is driven high
    ret = ftdi.set_bitmode(context, 0xf1, 0x20)
    if ret != 0:
        print('set_bitmode failed: %d' % ret)
        os._exit(1)

    ftdi.usb_close(context)
    ftdi.free(context)

    # rebind ftdi_sio driver, it was unbound when the device was opened above
    with open("/sys/bus/usb/drivers/ftdi_sio/bind", "w") as f:
        f.write("1-1.5.2:1.0")

main()
