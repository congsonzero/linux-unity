$ ls /sys/class/net    (enp0s25  lo  wlp3s0)
check wlp3s0 and wlan0
$ ls /etc/netplan/
check 01-network-manager-all.yaml or 50-cloud-init.yaml
$ sudoedit /etc/netplan/50-cloud-init.yaml
insert
 wifis:
        wlan0:
            optional: true
            access-points:
                "SSID-NAME-HERE":
                    password: "PASSWORD-HERE"
            dhcp4: true
don't use tab use space"
example
This file is generated from information provided by the datasource.  Changes
to it will not persist across an instance reboot.  To disable cloud-init's
network configuration capabilities, write a file
/etc/cloud/cloud.cfg.d/99-disable-network-config.cfg with the following:
network: {config: disabled}
network:
    ethernets:
        eth0:
            dhcp4: true
            match:
                driver:bcmgenet smsc95xx lan78xx
            optional: true
    version: 2
    wifis:
        wlp3s0:
            optional: true
            access-points:
                "SSID-NAME-HERE":
                    password: "PASSWORD-HERE"
            dhcp4: true
$ sudo netplan apply
if issue use
$ sudo netplan --debug apply
$ ip a