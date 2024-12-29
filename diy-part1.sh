#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#
#问题：git clone -b master https://github.com/sirpdboy/luci-theme-kucat.git和
#      git clone --depth=1 -b master https://github.com/sirpdboy/luci-theme-kucat  的效果一样吗？
#回答：两个命令都是用于克隆Git仓库的，有一些细微的差别：
#git clone -b master https://github.com/sirpdboy/luci-theme-kucat.git：这个命令克隆整个仓库（luci-theme-kucat.git）并检出master分支。
#git clone --depth=1 -b master https://github.com/sirpdboy/luci-theme-kucat：这个命令同样克隆仓库并检出master分支，但使用了--depth=1选项。这个选项创建一个浅克隆，只包含最新的提交，没有超过指定深度的提交历史。
#这两个命令的实际效果是，第二个命令（--depth=1）创建了一个更小的克隆，只包含最新的提交，而没有完整的提交历史。这对于只关注仓库的最新状态并且想要节省带宽和磁盘空间的情况可能会很有用。
#总的来说，就代码而言，这两个命令的结果可能是一样的，但第二个命令（--depth=1）创建了一个更小的克隆，没有完整的历史记录。
#sed -i '1i src-git small https://github.com/kenzok8/small' feeds.conf.default      
#sed -i '$a src-git small https://github.com/kenzok8/small' feeds.conf.default


sed -i '1i src-git kenzo https://github.com/kenzok8/openwrt-packages' feeds.conf.default
sed -i '2i src-git small https://github.com/kenzok8/small' feeds.conf.default
./scripts/feeds update -a && rm -rf feeds/luci/applications/luci-app-mosdns
rm -rf feeds/packages/net/{alist,adguardhome,mosdns,xray*,v2ray*,v2ray*,sing*,smartdns}
rm -rf feeds/packages/utils/v2dat
rm -rf feeds/packages/lang/golang
git clone https://github.com/kenzok8/golang feeds/packages/lang/golang
./scripts/feeds install -a 
