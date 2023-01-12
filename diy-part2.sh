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

### need some openwrt packages:



# Xray-core
git clone --depth=1  https://git.openwrt.org/feed/packages.git openwrtpackages
mv -n openwrtpackages/net/xray-core ./feeds/packages/net/

rm -rf openwrtpackages

# reinstall feeds
./scripts/feeds install -a

cd package/feeds/pacakges
ln -sf ../../../feeds/packages/net/xray-core .
cd -

### end openwrt packages

# Modify default IP
sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate
