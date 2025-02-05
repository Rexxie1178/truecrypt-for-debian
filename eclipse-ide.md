# Setup Eclipse IDE for C/C++ Developers
Download eclipse-inst-jre-linux64.tar.gz from https://www.eclipse.org/downloads/packages/installer.

Extract and install eclipse-inst-jre-linux64.tar.gz into the home directory.
```shell
cd ~/eclipse-inst-jre-linux64/eclipse-installer
./eclipse-inst
```
In the eclipse installer splash-screen select Eclipse IDE for C/C++ Developers.

## Prepare the source code
Before continuing make sure to walk through the instructions in README.md from **Build DIY** up to **Prepare the build directory**, where instead of moving ~/truecrypt-7.1a-source to ~/truecrypt-release, move it to ~/truecrypt and with that have prepared the following directories.
> ~/truecrypt<br>
> /usr/src/wxWidgets<br>

## Run the script eclipse-ide.sh
This will apply all patches to the source code, add wxwidgets (debug/release) and the eclipse project settings. 
```shell
cd ~/truecrypt
git clone https://github.com/rexxie1178/truecrypt-for-debian.git debian
cd debian
sudo chmod +x eclipse-ide.sh
./eclipse-ide.sh
```
## Start Eclipse

Start Eclipse and from the menu select File -> Open Projects from File System...,<br>
in the Import Projects from File System or Archive dialog -> click Directory...,<br>
in the Browse for Folder dialog select the ~/truecrypt-dev folder -> click open,<br>
back in the Import Projects from File System or Archive dialog -> click Finish.<br>

## Setup wxFormBuilder
Using wxFormBuilder can really help to understand the TrueCrypt user interface.
For download go to https://github.com/wxFormBuilder/wxFormBuilder.

### Prerequisites
```shell
sudo apt install libwxgtk3.2-dev libwxgtk-media3.2-dev libboost-dev cmake make git
```

### Build
```shell
git clone --recursive https://github.com/wxFormBuilder/wxFormBuilder
cd wxFormBuilder
cmake -S . -B _build -G "Unix Makefiles" --install-prefix "$PWD/_install" -DCMAKE_BUILD_TYPE=Release
cmake --build _build --config Release -j `nproc`
cmake --install _build --config Release
```

### Run
```shell
_install/bin/wxformbuilder
```

## Remarks
- Installing TrueCrypt on the development system will cause issues with debugging the application in Eclipse.

