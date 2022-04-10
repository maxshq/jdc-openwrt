#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate
sed -i '/TARGET_DEVICES += jcg_y2/a\\ndefine Device\/jdcloud_re-sp-01b\n  \$(Device\/dsa-migration)\n  \$(Device\/uimage-lzma-loader)\n  IMAGE_SIZE := 27328k\n  DEVICE_VENDOR := JDCloud\n  DEVICE_MODEL := RE-SP-01B\n  DEVICE_PACKAGES := kmod-fs-ext4 kmod-mt7603 kmod-mt7615e kmod-mt7615-firmware kmod-sdhci-mt7620 kmod-usb3 wpad-openssl\nendef\nTARGET_DEVICES += jdcloud_re-sp-01b' target/linux/ramips/image/mt7621.mk

sed -i '/lenovo,newifi-d1|\\/i\        jdcloud,re-sp-01b|\\' target/linux/ramips/mt7621/base-files/etc/board.d/02_network

sed -i '/mikrotik,routerboard-750gr3|\\/i\        jdcloud,re-sp-01b)\n                local index="\$(find_mtd_index "config")"\n                label_mac=\$(macaddr_canonicalize \$(dd if="/dev/mtd\${index}" bs=12 skip=17449 iflag=skip_bytes count=1 2>/dev/null))\n                lan_mac=\$label_mac\n                wan_mac=\$label_mac\n                ;;' target/linux/ramips/mt7621/base-files/etc/board.d/02_network 

sed -i '/linksys,e5600|\\/i\        jdcloud,re-sp-01b)\n                local index="\$(find_mtd_index "config")"\n                local label_mac=\$(macaddr_canonicalize \$(dd if="/dev/mtd\${index}" bs=12 skip=17449 iflag=skip_bytes count=1 2>/dev/null))\n                [ "\$PHYNBR" -eq 0 ] && echo \$label_mac > /sys\${DEVPATH}/macaddress\n                [ "\$PHYNBR" -eq 1 ] && echo macaddr_add \$label_mac 0x800000 > /sys\${DEVPATH}/macaddress\n                ;;' target/linux/ramips/mt7621/base-files/etc/hotplug.d/ieee80211/10_fix_wifi_mac

sed -i 's/set wireless.radio${devidx}.disabled=1/set wireless.radio${devidx}.disabled=0/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
