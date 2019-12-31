---
title: "Arch Linux Installation on X280"
date: 2018-12-23T10:32:34+09:00
tags: [""]
draft: false

comment: false
toc: false
contentCopyright: '<a rel="license noopener" href="https://creativecommons.org/licenses/by-nc-nd/4.0/" target="_blank">CC BY-NC-ND 4.0</a>'
reward: false
mathjax: true
---

**Set font to a larger one**
setfont sun12x22

**Test network environment**
ping google.com -c 3

**Prepare partitions**
fdisk /dev/nvme0n1

Swap:
/dev/nvme0n1p5 -> 16G
Root:
/dev/nvme0n1p6 -> 60G
Home:
/dev/nvme0n1p7 -> 34G

**Create filesystem**
mkswap /dev/nvme0n1p5
mkfs.ext4 /dev/nvme0n1p6
mkfs.ext4 /dev/nvme0n1p7

**Mount partitions**
swapon /dev/nvme0n1p5
mount /dev/nvme0n1p6 /mnt
mkdir /mnt/home
mount /dev/nvme0n1p7 /mnt/home

**Install Arch Linux base system**
pacstrap /mnt/ base base-devel

**Create fstab**
genfstab /mnt >> /mnt/etc/fstab
cat /mnt/etc/fstab

**Configure Arch Linux**
arch-chroot /mnt
echo "arch-arya" > /etc/hostname
vi /etc/hosts

vi /etc/locale.gen
locale-gen
echo LANG=en_US.UTF-8 > /etc/locale.conf
export LANG=en_US.UTF-8

ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
hwclock --systohc --utc

passwd
useradd -mg users -G wheel,storage,power -s /bin/bash your_new_user
passwd your_new_user
chage -d 0 your_new_user

mkinitcpio -p linux

systemctl start dhcpcd
systemctl enable dhcpcd

pacman -S grub efibootmgr os-prober
mkdir /boot/EFI
mount /dev/nvme0n1p1 /boot/EFI
grub-install --target=x86_64-efi  --bootloader-id=grub_uefi --recheck

pacman -S intel-ucode
grub-mkconfig -o /boot/grub/grub.cfg

umount -R /mnt
exit
reboot