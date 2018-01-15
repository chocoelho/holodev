#!/bin/sh

# a lot of distro's which have /etc/os-release will not have lsb_release
# installed as default (such as Arch Linux) 
if [ -f /etc/lsb-release ] || [ -f /etc/os-release ]; then
  # reference: https://github.com/brocaar/lora-gateway-bridge/issues/30#issue-213360185
  DISTRIB_ID=$(lsb_release -si)
  DISTRIB_CODENAME=$(lsb_release -sc)
  export DISTRIB_ID
  export DISTRIB_CODENAME
  OS=$DISTRIB_ID
elif [ -f /etc/debian_version ]; then
  OS=Debian
elif [ -f /etc/arch-release ]; then
  OS=Arch
elif [ -f /etc/SuSE-release ]; then
  OS=Suse
elif [ -f /etc/fedora-release ]; then
  OS=Fedora
else
  OS=$(uname -s)
fi

if [ -x "./development-setup/$OS.sh" ]; then
  "./development-setup/$OS.sh"
  ./holodev setup
else
  echo "W: ./development-setup/$OS.sh not found, aborting setup for holodev!"
  echo "W: You need to install the development dependencies by hand."
fi
