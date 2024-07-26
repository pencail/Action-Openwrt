[license]: /LICENSE
[license-badge]: https://img.shields.io/github/license/pencail/Action-Openwrt?style=flat-square
[prs]: https://github.com/pencail/Action-Openwrt/pulls
[prs-badge]: https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square
[issues]: https://github.com/pencail/Action-Openwrt/issues/new
[issues-badge]: https://img.shields.io/badge/Issues-welcome-brightgreen.svg?style=flat-square
[release]: https://github.com/pencail/Action-Openwrt/releases
[release-badge]: https://img.shields.io/github/v/release/pencail/Action-Openwrt?style=flat-square
[download]: https://github.com/pencail/Action-Openwrt/releases
[download-badge]: https://img.shields.io/github/downloads/pencail/Action-Openwrt/total?style=flat-square
<!-- [contact]: https://t.me/jerryk6 -->
<!-- [contact-badge]: https://img.shields.io/badge/Contact-telegram-blue?style=flat-square -->
[23.05-link]: /MarkDown/23.05.md
[en-us-release-log]: /RELEASE.md
[zh-cn-release-log]: /RELEASE_ZH.md
[official]: https://github.com/openwrt/openwrt
[immortalwrt]: https://github.com/immortalwrt/immortalwrt



<div align="center">

# Action-Openwrt(openwrt自动编译系统) 

[![license][license-badge]][license]
[![prs][prs-badge]][prs]
[![issues][issues-badge]][issues]
[![release][release-badge]][release]
[![download][download-badge]][download]
<!-- [![contact][contact-badge]][contact] -->

</div>

## 文件结构示意
```
|-- Action-Openwrt
    |-- .github
    |   |-- workflows
    |       |-- OpenWrt.yml
    |-- build
    |   |-- openwrt (内部放置配置文件、脚本等，用于编译时的版本控制，可放置多个)
    |   |   |-- DIY (存放自定义文件的文件夹，相当于openwrt源码目录)
    |   |   |-- diy-part1.sh (part1脚本)
    |   |   |-- diy-part2.sh (part2脚本)
    |   |   |-- xxx.config   (编译的配置文件，可放置多个)
    |   |   |-- settings.ini (预先设置的环境，使用哪个源码，哪个版本，使用哪个配置文件)
    |   |-- openwrt1
    |   |   |-- DIY
    |   |   |-- diy-part1.sh
    |   |   |-- diy-part2.sh
    |   |   |-- xxx.config
    |   |   |-- settings.ini
    |   |-- openwrt2
    |   |   |-- DIY
    |   |   |-- diy-part1.sh
    |   |   |-- diy-part2.sh
    |   |   |-- xxx.config
    |   |   |-- settings.ini
    |-- note
    |-- README.md
```

## 使用方法
修改完DIY、脚本等文件，去github action运行 Openwrt.yml 即可
BuildOpenwrt.yml 说明
```
 matrix:
    target: [openwrt_23.05.0]      ##此处为要编译的版本，和存放配置的文件夹对应
```
其余在Openwrt.yml中有对应注释

## 注意事项
1. nginx默认https同时ttyd终端无法显示

## 配置文件说明
[23.05][23.05-link]

## 任务
- [x] 美化readme
- [ ] 
- [ ] 



<!-- <style>
    hr:nth-of-type(1) {
        border-width: 10px 0 0 0 !important;
    }
</style> -->
