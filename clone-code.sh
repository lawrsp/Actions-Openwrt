#!/bin/bash

DEST_DIR=$1

# souce
git clone --depth=1 https://github.com/coolsnowwolf/lede -b master $DEST_DIR

# package:

cd $DEST_DIR/package

function sparse_clone_path() {
    local repos=$1
    local branch=$2
    local subdir=$3

    echo $repos $branch $subdirh

    dir=$(basename $repos)

    mkdir $dir
    cd $dir
    git init

    git remote add origin $repos
    git config core.sparsecheckout true
    echo $subdir >> .git/info/sparse-checkout
    git pull --depth 1 origin $branch
    cd ..
    mv -n $dir/$subdir ./
    rm -rf $dir
}

function clone_package() {
    if [[ "$3" != "" ]]; then
        sparse_clone_path $1 $2 $3
    else
        git clone --depth=1 $1 $2
    fi

    if [ "$?" != 0 ]; then
        echo "error on $1"
        pid="$( ps -q $$ )"
        kill $pid
    fi
}


#svn export https://git.openwrt.org/feed/packages/trunk/xray-core
#https://github.com/openwrt/feeds/trunk/packages/xray-core

### others

# OpenClash
clone_package  https://github.com/vernesong/OpenClash master luci-app-openclash


# AdGuardHome
#git clone --depth=1 https://github.com/kiddin9/openwrt-adguardhome
#mv -n openwrt-adguardhome/luci-app-adguardhome ./
#rm -rf openwrt-adguardhome


