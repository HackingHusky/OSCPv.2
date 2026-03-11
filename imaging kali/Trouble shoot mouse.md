```
sudo mkdir -p /etc/X11/xorg.conf.d
sudo nano /etc/X11/xorg.conf.d/20-vmware.conf
```
in file
```
Section "Device"
    Identifier "VMware SVGA"
    Driver "vmware"
    Option "HWCursor" "off"
EndSection

```

reboot
