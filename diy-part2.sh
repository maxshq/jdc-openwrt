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
 # fix2 + fix4.2
    #echo '修补 mt7621.mk'
    sed -i '/Device\/adslr_g7/i\define Device\/jdcloud_re-sp-01b\n  \$(Device\/dsa-migration)\n  \$(Device\/uimage-lzma-loader)\n  IMAGE_SIZE := 32448k\n  DEVICE_VENDOR := JDCloud\n  DEVICE_MODEL := RE-SP-01B\n  DEVICE_PACKAGES := kmod-fs-ext4 kmod-mt7603 kmod-mt7615e kmod-mt7615-firmware kmod-sdhci-mt7620 kmod-usb3 wpad-openssl\nendef\nTARGET_DEVICES += jdcloud_re-sp-01b\n\n' target/linux/ramips/image/mt7621.mk

    # fix3 + fix5.2
    echo '修补 02-network'
    sed -i -e '/lenovo,newifi-d1|\\/i\        jdcloud,re-sp-01b|\\' -e '/ramips_setup_macs/,/}/{/ampedwireless,ally-00x19k/i\        jdcloud,re-sp-01b)\n\t\tlan_mac=$(mtd_get_mac_ascii u-boot-env mac)\n\t\twan_mac=$(macaddr_add "$lan_mac" 1)\n\t\tlabel_mac=$lan_mac\n\t\t;;
    }' target/linux/ramips/mt7621/base-files/etc/board.d/02_network

    # fix5.1
    echo '修补 system.sh 以正常读写 MAC'
    sed -i 's#key"'\''=//p'\''#& \| head -n1#' package/base-files/files/lib/functions/system.sh
    #sed -i 's/set wireless.radio${devidx}.disabled=1/set wireless.radio${devidx}.disabled=0/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
# load dts
# echo '载入 mt7621_jdcloud_re-sp-01b.dts'
#curl --retry 3 -s --globoff "https://gist.githubusercontent.com/1-1-2/335dbc8e138f39fb8fe6243d424fe476/raw/[lean's%20lede]mt7621_jdcloud_re-sp-01b.dts" -o target/linux/ramips/dts/mt7621_jdcloud_re-sp-01b.dts
# ls -l target/linux/ramips/dts/mt7621_jdcloud_re-sp-01b.dts

# fix2 + fix4.2
# echo '修补 mt7621.mk'
#sed -i '/Device\/adslr_g7/i\define Device\/jdcloud_re-sp-01b\n  \$(Device\/dsa-migration)\n  \$(Device\/uimage-lzma-loader)\n  IMAGE_SIZE := 32448k\n  DEVICE_VENDOR := JDCloud\n  DEVICE_MODEL := RE-SP-01B\n  DEVICE_PACKAGES := lsblk block-mount kmod-fs-ext4 e2fsprogs fdisk kmod-sdhci-mt7620\nendef\nTARGET_DEVICES += jdcloud_re-sp-01b\n\n' target/linux/ramips/image/mt7621.mk
#sed -i '/linksys,e5600|\\/i\        jdcloud,re-sp-01b)\n		local index="$(find_mtd_index "config")"\n		local label_mac=\$(macaddr_canonicalize \$(dd if="/dev/mtd${index}" bs=12 skip=17449 iflag=skip_bytes count=1 2>\/dev\/null))\n		[ "$PHYNBR" -eq 0 ] \&\& echo \$label_mac > \/sys\${DEVPATH}\/macaddress\n		[ "$PHYNBR" -eq 1 ] \&\& macaddr_add \$label_mac 0x800000 > \/sys\${DEVPATH}\/macaddress\n		;;' target/linux/ramips/mt7621/base-files/etc/hotplug.d/ieee80211/10_fix_wifi_mac
# fix3 + fix5.2
# echo '修补 02-network'
#sed -i -e '/lenovo,newifi-d1|\\/i\        jdcloud,re-sp-01b|\\' -e '/ramips_setup_macs/,/}/{/ampedwireless,ally-00x19k/i\        jdcloud,re-sp-01b)\n\t\tlan_mac=$(mtd_get_mac_ascii u-boot-env mac)\n\t\twan_mac=$(macaddr_add "$lan_mac" 1)\n\t\tlabel_mac=$lan_mac\n\t\t;;
#}' target/linux/ramips/mt7621/base-files/etc/board.d/02_network
