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


function git_clone() {
    git clone --depth=1 $1 $2
    if [ "$?" != 0 ]; then
        echo "error on $1"
        pid="$( ps -q $$ )"
        kill $pid
    fi
}

git_clone https://git.openwrt.org/feed/packages.git openwrtpackages


# 没有 xray-core
rm -rf ./feeds/packages/net/xray-core
mv -n openwrtpackages/net/xray-core ./feeds/packages/net/

# lede 的 transmission 没有web管理
rm -rf ./feeds/packages/net/transmission
mv -n openwrtpackages/net/transmission ./feeds/packages/net/

rm -rf openwrtpackages

sed -i 's/transmission-daemon-openssl/transmission-daemon/' feeds/luci/applications/luci-app-transmission/Makefile
sed -i 's/transmission-daemon-openssl/transmission-daemon/' feeds/packages/net/transmission-web-control/Makefile


# reinstall feeds
./scripts/feeds install -a


cd package/feeds/packages
rm -rf xray-core
ln -sf ../../../feeds/packages/net/xray-core xray-core
cd -

### end openwrt packages

# Modify default IP
sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate
