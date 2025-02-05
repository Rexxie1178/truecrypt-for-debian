# How to create a Debian bookworm Virtual Machine in Proxmox running on AMD64 based hardware.
Download the netinst CD image for Debian GNU/Linux 12 (bookworm) system from [https://www.debian.org/releases/bookworm/debian-installer/.](https://www.debian.org/releases/bookworm/debian-installer/)


## Create a Debian 12 AMD64 virtual machine.
Select a storage from the left navigation pane to download the .iso to.<br>
Select ISO Images in the left sub-navigation pane.<br>
Click Download from URL and paste the download URL from above, click Query URL -> click Download.<br>

In Proxmox top right click the Create VM button and modify the following tabs accordingly.<br>
- <strong>[General]</strong> set Name: debian-12-gnome-amd64 -> click Next.<br>
- <strong>[OS]</strong> select Use CD/DVD disc image file (iso), set the Storage: local-btrfs, select the ISO image:, set the Type: to Linux, Version: to 6.x - 2.6 Kernel -> click Next.<br>
- <strong>[System]</strong> set Graphic card to VirtIO-GPU, the BIOS to OVMF (UEFI), check Add EFI Disk, select the EFI storage local-btrfs, set the SCSI Controller to VirtIO SCSI -> click Next.<br>
- <strong>[Disks]</strong> set Disk size (GIB): to 32 -> click Next.<br>
- <strong>[CPU]</strong> set Cores: 6 -> click Next.<br>
- <strong>[Memory]</strong> Memory (MIB): 8192 -> click Next.<br>
- <strong>[Network]</strong> -> click Next.<br>
- <strong>[Confirm]</strong> -> click Finish.<br>

Select the new created VM under Server View in the left pane.<br>
Click the >_Console button at the top right of the screen and select noVNC to start the VM.<br>
Follow the prompts to complete the OS installation.<br>

Welcome to AMD64 based Debian running on Proxmox VE.<br>


## Create a Debian 12 ARM64 virtual machine.
Select a storage from the left navigation pane to download the .iso to.<br>
Select ISO Images in the left sub-navigation pane.<br>
Click Download from URL and paste the download URL from above, click Query URL -> click Download.<br>

In Proxmox top right click the Create VM button and modify the following tabs accordingly.<br>
- <strong>[General]</strong> set Name: debian-12-gnome-amd64 -> click Next.<br>
- <strong>[OS]</strong> select Do not use any media and set the Type to Linux, Version to 6.x - 2.6 Kernel > click Next.<br>
- <strong>[System]</strong> set the Graphic card to VirtIO-GPU, the BIOS to OVMF (UEFI), uncheck the Add EFI Disk checkbox and set the SCSI Controller to VirtIO SCSI > click Next.<br>
- <strong>[Disks]</strong> set Disk size (GIB): to 32 -> click Next.<br>
- <strong>[CPU]</strong> set Cores: 6  and empty the Type: set it to Default (kvm64) -> click Next.<br>
- <strong>[Memory]</strong> Memory (MIB): 8192 -> click Next.<br>
- <strong>[Network]</strong> -> click Next.<br>
- <strong>[Confirm]</strong> -> click Finish.<br>

Select the ARM64 system in the left navigation pane.<br>
Under Virtual Machine in the left navigation sub-menu select Hardware.<br>
Click on the CD/DVD Drive to select it, click Remove at the top of the main content area, click Yes to confirm.<br>
Click Add, select CD/DVD Drive, set the Bus/Device to SCSI, select the Storage device where the ARM64 iso is uploaded, select the uploaded Debian ARM64 iso -> click Add.<br>
Select Options from the left navigation sub-menu.<br>
Double click Boot order to edit it, Drag/drop the SCSI device with Debian iso to the top of the list -> click OK.<br>

Under Server View right click the ProxMox node pve1 -> select >_Shell.<br>
Run the following commands in the terminal to edit the VM conf file (change xxx to the id for the ARM64 VM).<br>
```shell
nano /etc/pve/qemu-server/xxx.conf
```
Find the line starting with "vmgenid:" and comment it out by adding a # to the beginning of the line.<br>
Add the following line to the bottom of the .conf file.<br>
> arch: aarch64

Press CTRL+O, Enter, CTRL+X to write the changes to the conf file.<br>
Leave the node pve1 shell dialog -> type exit.<br>

Back in the Proxmox web UI, select the new created VM under Server View in the left pane.<br>
Click the >_Console button at the top right of the screen and select noVNC to start the VM.<br>
Follow the prompts to complete the OS installation.<br>

After the installation completes and ask to remove the installation media before reboot.<br>
Select Hardware from the left sub-navigation menu.<br>
Double click the CD/DVD Drive to edit it, select Do not use any media -> click OK.<br>
Click Add from the top menu and select EFI disk and point it to "local-btrfs".<br>

Select Console and click Continue to reboot the fresh ARM64 installation.<br>

1. Welcome to crippled booting ARM64 based Debian running on Proxmox VE.<br>

When starting the system first time after shutdown press ESC in the proxmox bootmenu to enter QEMU Virtual Machine settings.<br>
Create a new boot option in Boot Maintenance Manager -> Boot Options -> Add Boot Option -> ENTER -> \<EFI> -> \<debian> -> grubaa64.efi.<br>
Give it a name 'grubaa64.efi' -> ENTER -> Commit Changes and Exit.<br>
Select Change Boot Order -> ENTER -> use arrow keys to select the entry with grubaa64.efi, use SHIFT & + to move it to the top of the list and press ENTER -> Commit Changes and Exit.<br>
Press ESC -> ESC -> Reset to reboot and start the ARM64 VM.<br>

2. Welcome to ARM64 based Debian running on Proxmox VE.

