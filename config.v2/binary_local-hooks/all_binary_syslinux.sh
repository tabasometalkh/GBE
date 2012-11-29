#!/bin/sh
#
# Gemeinschaft 5
# live-helper hook to update syslinux boot menu
#
# Copyright (c) 2012, Julian Pawlowski <jp@jps-networks.eu>
# See LICENSE.GBE file for details.
#

LB_BOOTAPPEND_LIVE_DE="timezone=Europe/Berlin locales=de_DE.UTF-8 keyboard-layouts=de"
LB_BOOTAPPEND_LIVE_CH="timezone=Europe/Zurich locales=de_CH.UTF-8 keyboard-layouts=ch"
LB_BOOTAPPEND_LIVE_EN="timezone=Europe/London locales=en_US.UTF-8 keyboard-layouts=us"

# Copy default files
cp -pf binary_syslinux/splash.png binary/isolinux/
cp -pf binary_syslinux/stdmenu.cfg binary/isolinux/
cp -pf binary_syslinux/menu.cfg binary/isolinux/

# Live boot menu
sed -e "s|@KERNEL@|/live/vmlinuz|g" \
    -e "s|@INITRD@|/live/initrd.gz|g" \
    -e "s|@LB_BOOTAPPEND_LIVE_DE@|${LB_BOOTAPPEND_LIVE} ${LB_BOOTAPPEND_LIVE_DE}|g" \
    -e "s|@LB_BOOTAPPEND_LIVE_CH@|${LB_BOOTAPPEND_LIVE} ${LB_BOOTAPPEND_LIVE_CH}|g" \
    -e "s|@LB_BOOTAPPEND_LIVE_EN@|${LB_BOOTAPPEND_LIVE} ${LB_BOOTAPPEND_LIVE_EN}|g" \
    binary_syslinux/live.cfg.in > binary/isolinux/live.cfg

# Install menu
sed -e "s|@KERNEL@|/install/gtk/vmlinuz|g" \
    -e "s|@INITRD@|/install/gtk/initrd.gz|g" \
    -e "s|@LB_BOOTAPPEND_INSTALL@|video=vesa:ywrap,mtrr vga=788 quiet ${LB_BOOTAPPEND_INSTALL}|g" \
    binary_syslinux/install.cfg.in > binary/isolinux/install.cfg
