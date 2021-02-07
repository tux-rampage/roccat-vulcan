#!/bin/bash

cd $(dirname $(realpath $0))/../src

DATE=$(date -R)
VERSION="1.1.3-1"
RELEASE=$1
[[ -z $PPA_USER ]] && PPA_USER='Tom Kistner <tom@kistner.nu>'

if [[ -z $RELEASE ]]; then
    echo "Missing release name." >&2
    echo -e "\nUsage:\n\t$0 <release>\n\nArguments:\n\trelease\tThe distro release name (e.g. focal).\n"
    exit 1
fi

cat >debian/changelog <<END
roccat-vulcan ($VERSION~$RELEASE) $RELEASE; urgency=medium

  * Update to $VERSION

 -- $PPA_USER  $DATE
END

debuild -b -uc -us | tee debuild.log 2>&1
