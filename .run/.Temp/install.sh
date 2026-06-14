#!/bin/sh
# for f in */*.sh;do f="${f}";rm -rf "${f}";done
# for d in */;do d="${d%/}";cp -rf Install.sh ${d};done
# for f in *.run;do f="${f}";./${f} --target ${f%.run};done
# for d in */;do d="${d%/}";makeself --xz "${d}" "${d}.run" "${d}" ./Install.sh;done

if find . -type f -name '*.run' | grep -q "/";then
    find . -type f -name '*.run' -exec sh -c 'chmod +x "$1" && ./"$1" && rm -rf "$1"' _ {} \;
else
    if command -v opkg >/dev/null 2>&1;then
        echo "==> Update List..." && opkg update && clear
    
        echo "==> Installing packages..."
        find . -type f -name "*$(uname -m)*.ipk" -exec sh -c 'opkg install "$1" && rm -f "$1"' _ {} \;
        find . -type f -name "luci-app*.ipk" -exec sh -c 'opkg install "$1" && rm -f "$1"' _ {} \;
        find . -type f -name "luci-i18n*.ipk" -exec sh -c 'opkg install "$1" && rm -f "$1"' _ {} \;
        find . -type f -name "*.ipk" -exec sh -c 'opkg install "$1" && rm -f "$1"' _ {} \;
    
        echo "==> Done" ;elif command -v apk >/dev/null 2>&1;then
        echo "==> Update List..." && apk update && clear
    
        echo "==> Installing packages..."
        find . -type f -name "*$(uname -m)*.ipk" -exec sh -c 'apk add --force-overwrite "$1" && rm -f "$1"' _ {} \;
        find . -type f -name "luci-app*.ipk" -exec sh -c 'apk add --force-overwrite "$1" && rm -f "$1"' _ {} \;
        find . -type f -name "luci-i18n*.ipk" -exec sh -c 'apk add --force-overwrite "$1" && rm -f "$1"' _ {} \;
        find . -type f -name "*.ipk" -exec sh -c 'apk add --force-overwrite "$1" && rm -f "$1"' _ {} \;
        
        echo "==> Done";else echo "==> System Not Supported";fi
fi