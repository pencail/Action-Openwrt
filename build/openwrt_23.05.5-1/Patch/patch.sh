#!/bin/bash

# 启用补丁文件
cat >> .config << 'EOF'
SOURCE_TREE_OVERRIDE=YES
SOURCE_TREE_OVERRIDE_PATCHES=$(TOPDIR)/patches
EOF