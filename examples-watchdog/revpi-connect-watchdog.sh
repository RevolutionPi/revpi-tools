#!/bin/sh
#
# SPDX-License-Identifier: MIT
#
# Copyright 2019 KUNBUS GmbH
#

while : ; do
    # let watchdog trigger on loss of internet connectivity
    if ! /bin/ping -c1 -n 8.8.8.8 > /dev/null 2>&1 ; then
        exit
    fi

    # feed watchdog
    value=$(piTest -q -1 -r RevPiLED)
    value=$(( ($value + 128) % 256))
    piTest -w RevPiLED,"$value"
    sleep 10
done
