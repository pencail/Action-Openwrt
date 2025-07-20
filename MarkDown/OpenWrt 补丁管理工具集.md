# 🧩 OpenWrt 补丁管理工具集

PatchKit 是一个用于管理、应用和追踪 OpenWrt 补丁的轻量级工具集。它通过模块化设计，实现补丁清单控制、自动应用、日志分析、验证校验等功能，帮助开发者高效维护固件构建流程。

---

## ✨ 功能特性

- ✅ **补丁自动应用**：支持冲突检测、智能跳过已应用补丁
- 📋 **补丁清单配置**：通过 `patchmap.yml` 控制启用状态、用途说明与标签分类
- 📜 **补丁日志生成**：生成标准化 `patchlog.txt`，记录应用与跳过情况
- 🔍 **补丁清单验证**：检测 `patchmap.yml` 的字段完整性与语义合法性
- 📊 **补丁日志分析**：统计已应用、跳过、缺失补丁，并分组展示
- 🆙 **命令行工具化**：支持独立运行或集成至 GitHub Actions 构建流程

---

## 📁 推荐项目结构
Action-Openwrt
├──project-root/ 
│   ├── patches/                   # 存放各类补丁，可按模块细分子目录 
│   │   ├── kernel/
│   │   ├── packages/
│   │   ├── platform/ 
│   ├── patchmap.yml 
|   └── 其他配置文件（各版本文件）
├── scripts/ 
│   └── apply_all_patches.sh   # 主补丁应用脚本（支持 patchmap） 
├── tools/ 
│   ├── validate_patchmap.py   # 补丁清单验证器 
│   └── patchlog_report.py     # 补丁日志分析器

---

## 🚀 快速开始

### 1️⃣ 应用补丁

```
bash scripts/apply_all_patches.sh \
     patches \
     patchmap.yml \
     logs/patchlog.txt
```
脚本会根据 patchmap.yml 中 enabled: true 条目自动打补丁，并记录日志。

### 2️⃣ 验证 patchmap 清单结构
```
python3 tools/validate_patchmap.py patchmap.yml
```
输出格式示例：
```
01. ✅启用 - 内核 MD5 校验绕过
    路径: patches/kernel/100-md5-bypass.patch
    标签: kernel, global
    注释: 适用于所有平台的通用补丁
```
### 3️⃣ 分析补丁日志报告
```
python3 tools/patchlog_report.py logs/patchlog.txt
```
输出格式示例：
```
✅ 已应用: 5
⚠️ 跳过: 2
🚫 缺失: 0

📂 kernel/
   └─ 100-md5-bypass.patch
📂 packages/
   └─ rust-version-fix.patch
```

### 📝 示例 patchmap.yml
```
patches:
  - path: patches/kernel/100-md5-bypass.patch
    name: 绕过 MD5 校验
    enabled: true
    tags: [kernel, global]
    comment: 适用于所有设备的 .vermagic 校验修复补丁

  - path: patches/packages/01-rust-version-fix.patch
    name: 修复 Rust 编译
    enabled: true
    tags: [packages, x86]
    comment: 避免 Rust 编译失败，适用于 x86 架构
```
### 💡 使用建议

- 按模块划分补丁目录（kernel、packages、platform 等），保持结构清晰
- 所有补丁通过 patchmap.yml 统一管理：启用状态、分类标签、用途注释
- 将 patchlog.txt 上传为构建产物或发布页面附件
- 可拓展为 Markdown/HTML 报告或 Release 打包脚本

### 📬 反馈与贡献

PatchKit 旨在为 OpenWrt 工程化流程提供灵活、智能的补丁管理能力。
欢迎提出建议、提交补丁清单格式改进、或扩展功能模块！