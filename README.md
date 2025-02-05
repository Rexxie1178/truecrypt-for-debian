# TrueCrypt for Debian
TrueCrypt for Debian is a revival of the legendary open source TrueCrypt encryption software, updated to work seamlessly on Debian 12 (Bookworm). This project builds upon the foundations laid by Stefan Sundin's TrueCrypt 7.1a-15 [truecrypt.deb](https://github.com/stefansundin/truecrypt.deb), which was originally designed for Ubuntu 16 (Xenial). The goal is to provide a reliable, user-friendly, and secure encryption solution for Debian users, while maintaining the core functionality and spirit of the original TrueCrypt 7.1a.

In an era where data security is of utmost importance, TrueCrypt for Debian offers a robust and battle-tested encryption platform. This project is useful for individuals seeking to protect their sensitive data from unauthorized access. By providing a Debian-compatible version of TrueCrypt anyone can continue to rely on this trusted encryption solution.

The modifications made to achieve compatibility with Debian 12 (Bookworm) are significant, including updates to the build process, patches for deprecated code, and fixes for various GUI issues, as well as the addition of HTML help with FAQ integration, resulting in a stable and functional encryption tool ready for use on modern Debian systems.

## Install
To install the package and work secure on Debian 12 (bookworm) [administrator right is needed](https://github.com/rexxie1178/truecrypt-for-debian/blob/master/htmlhelp/miscellaneous/using-truecrypt-without-administrator-privileges/index.html).<br>
Download the desired package(s) from the releases section in this repository.
```shell
cd ~/Downloads
wget https://github.com/rexxie1178/truecrypt-for-debian/releases/download/7.1a-d12.0/truecrypt_7.1a-d12.0_amd64.deb
```
Download the to the package corresponding .asc file.
```shell
wget https://github.com/rexxie1178/truecrypt-for-debian/releases/download/7.1a-d12.0/truecrypt_7.1a-d12.0_amd64.deb.asc
```
Download the signed hash file truecrypt-sha256sum.txt.
```shell
wget https://github.com/rexxie1178/truecrypt-for-debian/releases/download/7.1a-d12.0/truecrypt_7.1a-d12.0_sha256sum.txt
```
Download the public key rexxie-#1178-public-key.asc.
```shell
wget -O rexxie-#1178-public-key.asc https://github.com/Rexxie1178/gpg-public-keys/blob/main/rexxie-%231178-public-key.asc?raw=true
```
Import public key.
```shell
gpg --import rexxie-#1178-public-key.asc
```
Which shall return:
> gpg: key 836FDCA03415BC55: public key "Rexxie #1178 <rexxie1178@proton.me>" imported<br>
> gpg: Total number processed: 1<br>
> gpg:               imported: 1<br>

Verify the signature of the hash file.
```shell
gpg --verify truecrypt_7.1a-d12.0_sha256sum.txt
```
Which shall return:
> gpg: Signature made Fri 23 Aug 2024 08:17:57 PM +07<br>
> gpg:                using RSA key 4A0EDC9D2585438F1D5595FB836FDCA03415BC55<br>
> gpg: Good signature from "Rexxie #1178 <rexxie1178@proton.me>" [unknown]<br>
> gpg: WARNING: This key is not certified with a trusted signature!<br>
> gpg:          There is no indication that the signature belongs to the owner.<br>
> Primary key fingerprint: 4A0E DC9D 2585 438F 1D55  95FB 836F DCA0 3415 BC55<br>

Verify the checksum of the downloads.
```shell
grep "$(basename truecrypt_7.1a-d12.0_amd64.deb)" truecrypt_7.1a-d12.0_sha256sum.txt | sha256sum -c -
```
Which shall return:
> truecrypt_7.1a-d12.0_amd64.deb: OK<br>
> truecrypt_7.1a-d12.0_amd64.deb.asc: OK<br>

Verify the signature of the package.
```shell
gpg --verify truecrypt_7.1a-d12.0_amd64.deb.asc truecrypt_7.1a-d12.0_amd64.deb
```
Which shall return:
> gpg: Signature made Fri 23 Aug 2024 08:17:57 PM +07<br>
> gpg:                using RSA key 4A0EDC9D2585438F1D5595FB836FDCA03415BC55<br>
> gpg: Good signature from "Rexxie #1178 <rexxie1178@proton.me>" [unknown]<br>
> gpg: WARNING: This key is not certified with a trusted signature!<br>
> gpg:          There is no indication that the signature belongs to the owner.<br>
> Primary key fingerprint: 4A0E DC9D 2585 438F 1D55  95FB 836F DCA0 3415 BC55<br>

Install the package.
```shell
sudo apt update 
sudo dpkg -i truecrypt_7.1a-d12.0_amd64.deb
```
## Build DIY
The project is build on a Debian 12 (Bookworm) system running in a Proxmox Virtual Environment 8.2.2. For Proxmox download and installation instructions visit [https://www.proxmox.com](https://www.proxmox.com/en/proxmox-virtual-environment/overview). To setup the Debian 12 (Bookworm) system in Proxmox follow the instructions from [proxmox-vm.md](https://github.com/rexxie1178/truecrypt-for-debian/blob/master/proxmox-vm.md).

### Prerequisites
Update and prepare the system.
```shell
sudo apt update 
sudo apt install git build-essential devscripts debhelper pkg-config nasm bash-completion libfuse-dev libnotify-dev libayatana-appindicator3-dev libgtk-3-dev libwxgtk3.2-dev
```
Reboot the build system.
### Download sources
After login [download](https://github.com/rexxie1178/truecrypt-for-debian/blob/master/htmlhelp/technical-details/source-code/index.html) TrueCrypt 7.1a.
```shell
cd ~/Downloads
wget "https://cyberside.net.ee/truecrypt/TrueCrypt 7.1a Source.tar.gz"
wget "https://cyberside.net.ee/truecrypt/TrueCrypt 7.1a Source.tar.gz.sig"
wget https://cyberside.net.ee/truecrypt/TrueCrypt-Foundation-Public-Key.asc
```
Import public key.
```shell
gpg --import TrueCrypt-Foundation-Public-Key.asc
```
Which shall return:
> gpg: key E3BA73CAF0D6B1E0: 1 signature not checked due to a missing key<br>
> gpg: key E3BA73CAF0D6B1E0: public key "TrueCrypt Foundation <contact@truecrypt.org>" imported<br>
> gpg: Total number processed: 1<br>
> gpg:              unchanged: 1<br>

Verify the signature of the source archive.
```shell
gpg --verify "TrueCrypt 7.1a Source.tar.gz.sig" "TrueCrypt 7.1a Source.tar.gz"
```
Which shall return:
> gpg: Signature made 2012-02-08T03:45:26 +07<br>
> gpg:                using DSA key E3BA73CAF0D6B1E0<br>
> gpg: Good signature from "TrueCrypt Foundation <contact@truecrypt.org>" [unknown]<br>
> gpg: WARNING: This key is not certified with a trusted signature!<br>
> gpg:          There is no indication that the signature belongs to the owner.<br>
> Primary key fingerprint: C5F4 BAC4 A7B2 2DB8 B8F8  5538 E3BA 73CA F0D6 B1E0<br>

Extract the archive and rename the directory to truecrypt-release.
```shell
tar -xvf "TrueCrypt 7.1a Source.tar.gz" -C ~
mv ~/truecrypt-7.1a-source ~/truecrypt-release
```
Download wxWidgets.
```shell
wget https://github.com/wxWidgets/wxWidgets/releases/download/v3.2.5/wxWidgets-3.2.5.tar.bz2
```
Verify the checksum of the source archive.
```shell
sha1sum wxWidgets-3.2.5.tar.bz2
```
Which shall return:
> 4ffee63f4109cafe98b82b44adec6ed9a4e4ad1e  wxWidgets-3.2.5.tar.bz2

Extract the archive and move the directory to /usr/src/wxWidgets.
```shell
tar xjvf wxWidgets-3.2.5.tar.bz2 -C ~
sudo mv ~/wxWidgets-3.2.5 /usr/src/wxWidgets
```
### Prepare the build directory
Download the package sources.
```shell
wget https://github.com/rexxie1178/truecrypt-for-debian/releases/download/7.1a-d12.0/truecrypt_7.1a-d12.0.debian.tar.xz
```
Verify the checksum of the download.
```shell
grep "$(basename truecrypt_7.1a-d12.0.debian.tar.xz)" truecrypt_7.1a-d12.0_sha256sum.txt | sha256sum -c -
```
Which shall return:
> truecrypt_7.1a-d12.0.debian.tar.xz: OK<br>

Extract the archive and move it into the truecrypt-release directory.
```shell
tar -xf truecrypt_7.1a-d12.0.debian.tar.xz -C ~
mv ~/debian ~/truecrypt-release
```
### Build the package
```shell
cd ~/truecrypt-release/debian
dpkg-buildpackage -i -us -uc -b
```
When the build finished.
```shell
cd ~
ls truecrypt*.deb
```
will list two packages.
> truecrypt_7.1a-d12.0_amd64.deb<br>
> truecrypt-cli_7.1a-d12.0_amd64.deb<br>

## Develop DIY
Take this package to the next level by following the instructions in [eclipse-ide.md](https://github.com/rexxie1178/truecrypt-for-debian/blob/master/eclipse-ide.md).

## Tipping private bits
If the information found in this corner of the internet is invaluable, consider sending over appreciation in the form of money for value. Accepted are Pirate (ARRR) and Monero (XMR), both private-by-default cryptocurrencies that prioritize security and anonymity. Learn more about Pirate (ARRR) at [https://piratechain.com](https://piratechain.com/) and about Monero (XMR) at [https://getmonero.org](https://getmonero.org).

Using this type of privacy-focused internet money supports the community and promotes financial sovereignty and freedom. Much appreciated – every bit counts.

Pirate wallet address:
> zs180upk25p5mmr5k9hklenljp2hyamyyeqct0vz3gf8kz0sqz3z46cajx67zvjlpsplw3sc9027pn<br>![arrr-address](https://github.com/user-attachments/assets/bd063343-74ee-4aa8-8847-69d8ffc38847)


Monero wallet address:
> 44QU6st44kR3U5ASuk2X5wEjKyDyXoyZr5Xb2gnaEdcJaS42xFvynaD1cQ89iz1X2jRJQzwh5w4pYYizZfzYErQFEx3RTc8<br>![xmr-address](https://github.com/user-attachments/assets/4e503df6-aba3-4829-952f-8727b8604b17)


## References
At the moment of writing this README.md the sources were found at the following locations.

### PKCS11 sources
- [https://github.com/stefansundin/truecrypt.deb](https://github.com/stefansundin/truecrypt.deb)
- [https://github.com/pyauth/python-pkcs11/tree/master/pkcs11](https://github.com/pyauth/python-pkcs11/tree/master/pkcs11)
- [https://github.com/Pkcs11Interop/PKCS11-SPECS/tree/master/v2.20](https://github.com/Pkcs11Interop/PKCS11-SPECS/tree/master/v2.20)

### TrueCrypt 7.1a sources
- [https://launchpad.net/~stefansundin/+archive/ubuntu/truecrypt/+files/truecrypt_7.1a.orig.tar.gz](https://launchpad.net/~stefansundin/+archive/ubuntu/truecrypt/+files/truecrypt_7.1a.orig.tar.gz)
- [https://cyberside.net.ee/truecrypt](https://cyberside.net.ee/truecrypt)
- [https://github.com/AuditProject/truecrypt-verified-mirror](https://github.com/AuditProject/truecrypt-verified-mirror)
- [https://github.com/fauxfaux/truecrypt](https://github.com/fauxfaux/truecrypt)
- [https://mirror.ntzk.de/truecrypt-archive](https://mirror.ntzk.de/truecrypt-archive)
- [https://truecrypt.scratchbook.ch](https://truecrypt.scratchbook.ch)



