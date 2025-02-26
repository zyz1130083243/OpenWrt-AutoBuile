#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

# Modify default IP
sed -i 's/192.168.1.1/192.168.5.1/g' package/base-files/files/bin/config_generate

# Modify default theme
git clone https://github.com/jerrykuku/luci-theme-argon.git package/feeds/luci/themes/luci-theme-argon
#sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# Modify hostname
#sed -i 's/OpenWrt/P3TERX-Router/g' package/base-files/files/bin/config_generate

# 默认开启无线WIFI
sed -i 's/set wireless.${name}.disabled=1/set wireless.${name}.disabled=0/' package/kernel/mac80211/files/lib/wifi/mac80211.sh

# 修改kernel内核校验值
# echo 03ba5b5fee47f2232a088e3cd9832aec >> .vermagic
# cat .vermagic
# sed -i '/vermagic/s/.*/  cp $(TOPDIR)\/vermagic $(LINUX_DIR)\/.vermagic/' include/kernel-defaults.mk
# sed -i '/md5/s/.*/  STAMP_BUILT:=$(STAMP_BUILT)_$(shell cat $(LINUX_DIR)\/.vermagic)/' package/kernel/linux/Makefile

# 修改 LUCI 源
sed -i  's/downloads.openwrt.org\/releases\/23.05-SNAPSHOT/archive.openwrt.org\/releases\/23.05.4/'  include/version.mk

# 修改默认时区
sed -i "s/set system.@system\[-1\].timezone=.*$/set system.@system[-1].timezone='CST-8'/"  package/base-files/files/bin/config_generate
sed -i "/set system.@system\[-1\].timezone=/a set system.@system[-1].zonename='Asia/Shanghai'"  package/base-files/files/bin/config_generate
