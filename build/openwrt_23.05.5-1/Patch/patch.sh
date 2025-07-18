#!/bin/bash

# 将补丁文件复制到openwrt根目录
cp -Rf $GITHUB_WORKSPACE/build/${{github.event.inputs.target}}/Patch/patches patches

# 启用补丁文件
cat >> .config << 'EOF'
SOURCE_TREE_OVERRIDE=YES
SOURCE_TREE_OVERRIDE_PATCHES=$(TOPDIR)/patches
EOF