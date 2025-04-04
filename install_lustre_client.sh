#!/bin/bash

set -e

echo "[*] Updating system..."
sudo dnf update -y

echo "[*] Installing build tools and dependencies..."
sudo dnf install -y wget curl dnf-utils grub2-tools kernel-devel gcc make

echo "[*] Installing an older kernel compatible with Lustre..."
sudo dnf install -y kernel-4.18.0-425.19.2.el8_7.x86_64 kernel-core-4.18.0-425.19.2.el8_7.x86_64 kernel-devel-4.18.0-425.19.2.el8_7.x86_64

echo "[*] Setting default boot kernel to 4.18.0-425..."
sudo grub2-set-default 1
sudo grub2-mkconfig -o /boot/grub2/grub.cfg

echo "[*] Rebooting into compatible kernel..."
sleep 2
sudo reboot

