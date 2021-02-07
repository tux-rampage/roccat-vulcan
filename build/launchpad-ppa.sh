#!/bin/bash

cd $(dirname $(realpath $0))/../src

DATE=$(date -R)
VERSION="1.1.3-1"
[[ -z $PPA_USER ]] && PPA_USER='Tom Kistner <tom@kistner.nu>'
[[ -z $PPA_TARGET ]] && PPA_TARGET='ppa:duncanthrax/roccat-vulcan'

for RELEASE in focal eoan disco cosmic bionic
do

cat >debian/changelog <<END
roccat-vulcan ($VERSION~$RELEASE) $RELEASE; urgency=medium

  * Update to $VERSION

 -- $PPA_USER  $DATE
END

debuild -S | tee debuild.log 2>&1
dput $PPA_TARGET "$(perl -ne 'print $1 if /dpkg-genchanges --build=source >(.*)/' debuild.log)"
rm -f debuild.log

done
