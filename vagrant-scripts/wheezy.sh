#!/bin/sh

echo 'deb http://http.debian.net/debian wheezy-backports main' > /etc/apt/sources.list.d/backports.list
echo 'Package: *'                       > /etc/apt/preferences.d/backports
echo 'Pin: release a=wheezy-backports' >> /etc/apt/preferences.d/backports
echo 'Pin-Priority: 600'               >> /etc/apt/preferences.d/backports

echo 'cgroup /sys/fs/cgroup cgroup defaults' > /etc/fstab
mount -t cgroup cgroup /sys/fs/cgroup

mkdir /etc/dnsmasq.d
echo 'interface=eth0'   > /etc/dnsmasq.d/vagrant
echo 'bind-interfaces' >> /etc/dnsmasq.d/vagrant
service dnsmasq restart