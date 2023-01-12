#!/bin/bash

DEST_DIR=$1

# souce
git clone --depth=1 https://github.com/coolsnowwolf/lede -b master $DEST_DIR

# package:

cd $DEST_DIR/package


svn export https://git.openwrt.org/feed/packages/trunk/xray-core
https://github.com/openwrt/feeds/trunk/packages/xray-core

### others

# OpenClash
git clone --depth=1 https://github.com/vernesong/OpenClash
mv -n OpenClash/luci-app-openclash ./
rm -rf OpenClash

# AdGuardHome
git clone --depth=1 https://github.com/kiddin9/openwrt-adguardhome
mv -n openwrt-adguardhome/luci-app-adguardhome ./
rm -rf openwrt-adguardhome


