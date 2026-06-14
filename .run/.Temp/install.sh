#!/bin/sh

if command -v opkg >/dev/null 2>&1; then
    echo "==> Update List..."
    opkg update && clear

    echo "==> Installing packages..."
    find . -type f -name "*$(uname -m)*.ipk" -exec sh -c 'opkg install "$1" && rm -f "$1"' _ {} \;
    find . -type f -name "luci-app*.ipk" -exec sh -c 'opkg install "$1" && rm -f "$1"' _ {} \;
    find . -type f -name "luci-i18n*.ipk" -exec sh -c 'opkg install "$1" && rm -f "$1"' _ {} \;
    find . -type f -name "*.ipk" -exec sh -c 'opkg install "$1" && rm -f "$1"' _ {} \;

    echo "==> Done"
elif command -v apk >/dev/null 2>&1; then
    echo "==> Update List..."
    apk update && clear

    echo "==> Installing packages..."
    find . -type f -name "*$(uname -m)*.ipk" -exec sh -c 'apk add --force-overwrite "$1" && rm -f "$1"' _ {} \;
    find . -type f -name "luci-app*.ipk" -exec sh -c 'apk add --force-overwrite "$1" && rm -f "$1"' _ {} \;
    find . -type f -name "luci-i18n*.ipk" -exec sh -c 'apk add --force-overwrite "$1" && rm -f "$1"' _ {} \;
    find . -type f -name "*.ipk" -exec sh -c 'apk add --force-overwrite "$1" && rm -f "$1"' _ {} \;
    
    echo "==> Done"
else
    echo "==> System Not Supported"
fi
