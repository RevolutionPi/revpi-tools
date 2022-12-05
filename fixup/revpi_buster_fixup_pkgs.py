#!/usr/bin/env python3
#
# SPDX-License-Identifier: GPL-2.0
#
# Copyright 2021 KUNBUS GmbH
#

"""
This script should workaround some upgrade bugs regarding nodered, npm and
nodejs. Some packages from stretch-backports have a higher version than the
packages from buster. To fix these issues some packages will be removed and
reinstalled. Some packages will be purged as they are not needed and not
available on buster.

Since the RevPi Buster release npm. This script will also purge
the nodered Debian package. Nodered should be installed from npm.
"""

import aptsources.distro
from aptsources.sourceslist import SourcesList, SourceEntry
import apt.cache
import apt.package
import subprocess

# These packages don't exist for buster
PkgsPurge = [
    # the noderedrevpinodes-server 1.0.1 depends on nodered
    ("noderedrevpinodes-server", "1.0.1"),
    # Use the nodered npm package!
    ("nodered", "1.0.6-1"),
    ("node-psl", "1.7.0+ds-2"),
    ("libjs-psl", "1.7.0+ds-2"),
    ("libuv1-dbgsym", "1.34.2-1~bpo9+1"),
    ("node-debbundle-es-to-primitive", "1.2.1+~cs8.3.13-1"),
    ("node-define-properties", "1.1.3-1"),
    ("node-red-contrib-revpi-nodes", "*")
]

# These packages have lower versions in buster
PkgsDowngrade = [
    ("libuv1", "1.34.2-1~bpo9+1"),
    ("libuv1-dev", "1.34.2-1~bpo9+1"),
    ("npm", "6.14.5+ds-1"),
    ("node-asap", "2.0.6-2"),
    ("node-bl", "4.0.2-1"),
    ("node-ci-info", "2.0.0-1"),
    ("node-colors", "1.4.0-1"),
    ("node-columnify", "1.5.4-3"),
    ("node-configstore", "5.0.1-1"),
    ("node-crypto-random-string", "3.2.0-1"),
    ("node-debug", "4.1.1+~cs4.1.5-1"),
    ("node-dot-prop", "5.2.0-1"),
    ("node-err-code", "2.0.0+dfsg-1"),
    ("node-es6-promise", "4.2.8-7"),
    ("node-fast-deep-equal", "1.1.0-1"),
    ("node-function-bind", "1.1.1+repack-1"),
    ("node-genfun", "5.0.0-1"),
    ("node-ip", "1.1.5-5"),
    ("node-ip-regex", "4.1.0-2"),
    ("node-is-path-inside", "1.0.1-1"),
    ("node-lodash", "4.17.15+dfsg-2"),
    ("node-lodash-packages", "4.17.15+dfsg-2"),
    ("node-make-dir", "3.0.2-1"),
    ("node-mime", "2.4.4+dfsg-1"),
    ("node-ms", "2.1.2+~cs0.7.31-1"),
    ("node-npm-bundled", "1.1.1-1"),
    ("node-npm-package-arg", "6.1.1-1"),
    ("node-number-is-nan", "2.0.0-1"),
    ("node-p-is-promise", "3.0.0-1"),
    ("node-promise-retry", "1.1.1-4"),
    ("node-readable-stream", "3.4.0-2"),
    ("node-spdx-exceptions", "2.3.0-1"),
    ("node-unique-string", "1.0.0-2"),
    ("libmodbus-dev", "3.1.6-2~bpo10+2"),
    ("libmodbus5", "3.1.6-2~bpo10+2")
]

def disable_sourceslist():
    sourceslist = SourcesList()
    sourceslist.refresh()

    dist = "stretch"
    dist_backports = dist + "-backports"

    for source in sourceslist:
        if not source.disabled and not source.invalid:
            if source.dist == dist:
                print("WARNING: Found package repository for '" + dist + "' distribution:")
                print("\t" + source.str().strip())
            if source.uri == "http://packages.revolutionpi.de/" and source.dist == dist_backports:
                print("WARNING: Active '" + dist_backports + "' repository found:")
                print("\t" + source.str().strip())
                print("\tThis repository will be disabled!")
                source.set_enabled(False)
    sourceslist.save()

def handle_backport_pkgs():
    cache = apt.cache.Cache()
    cache.update()
    cache.open()

    for p in PkgsDowngrade:
        if  p[0] in cache:
            pkg = cache[p[0]]
            if pkg.is_installed and pkg.installed.version == p[1]:
                for v in pkg.versions:
                    if v.downloadable:
                        print("Downgrade package: " + pkg.name + " "
                            + pkg.installed.version + " => " + v.version)
                        auto = pkg.is_auto_installed
                        if pkg.name == "npm":
                            auto = False
                        pkg.candidate = v
                        pkg.mark_install(True, True, not auto)
                        break

    for p in PkgsPurge:
        if  p[0] in cache:
            pkg = cache[p[0]]
            if pkg.is_installed and (p[1] == "*" or pkg.installed.version == p[1]):
                print("Purge package: " + pkg.name)
                pkg.mark_delete(False, True)

    # FIXME retry if download fails
    cache.commit()
    cache.close()


def main():
    dist = aptsources.distro.get_distro()
    if dist.codename != "buster":
        print("WARNING: Wrong distribution: " + dist.codename)
        print("\tExpecetd distribution is 'buster'.")
        exit(1)

    disable_sourceslist()
    handle_backport_pkgs()

if __name__ == '__main__':
    main()
