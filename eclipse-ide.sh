#!/bin/bash

cd ~/truecrypt

git init
git add .
git commit -m "master"

git branch xenial
git checkout xenial

while read patch; do
    
    if [[ $patch = "truecrypt-7.1a-d12-build.patch" ]]
    then
        break
    fi
    
    git apply "./debian/patches/"$patch
    git add .
    git commit -m "apply "$patch
    
done < ./debian/patches/series

git branch bookworm
git checkout bookworm

mv ~/truecrypt/debian/.settings .
mv ~/truecrypt/debian/.cproject .
mv ~/truecrypt/debian/.project .
echo '/.cproject' > .gitignore
echo '/.project' >> .gitignore
echo '/.settings/' >> .gitignore
git add .
git commit -m "add eclipse project and settings"

git apply "./debian/patches/truecrypt-7.1a-d12-build.patch"
git add .
git commit -m "apply truecrypt-7.1a-d12-build.patch"

echo 'Make wxwidgets static library debug version...'
make WX_ROOT=/usr/src/wxWidgets DEBUG=1 wxbuild
echo '/wxdebug/' >> .gitignore
git add .
git commit -m "add wxwidgets for debug"

echo 'Make wxwidgets static library release version...'
make WX_ROOT=/usr/src/wxWidgets wxbuild
echo '/wxrelease/' >> .gitignore
git add .
git commit -m "add wxwidgets for release"

git apply "./debian/patches/truecrypt-7.1a-d12-gcc12.patch"
git add .
git commit -m "apply truecrypt-7.1a-d12-gcc12.patch"

git apply "./debian/patches/truecrypt-7.1a-d12-gtk3-gui.patch"
git add .
git commit -m "apply truecrypt-7.1a-d12-gtk3-gui.patch"

git apply "./debian/patches/truecrypt-7.1a-d12-htmlhelp.patch"
git add .
git commit -m "apply truecrypt-7.1a-d12-htmlhelp.patch"

git apply "./debian/patches/truecrypt-7.1a-d12-deprecated.patch"
git add .
git commit -m "apply truecrypt-7.1a-d12-deprecated.patch"

git apply "./debian/patches/truecrypt-7.1a-d12-lockfile.patch"
git add .
git commit -m "apply truecrypt-7.1a-d12-lockfile.patch"
