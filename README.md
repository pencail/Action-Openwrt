[license]: /LICENSE
[license-badge]: https://img.shields.io/github/license/jerrykuku/luci-theme-argon?style=flat-square&a=1
[prs]: https://github.com/jerrykuku/luci-theme-argon/pulls
[prs-badge]: https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square
[issues]: https://github.com/jerrykuku/luci-theme-argon/issues/new
[issues-badge]: https://img.shields.io/badge/Issues-welcome-brightgreen.svg?style=flat-square
[release]: https://github.com/jerrykuku/luci-theme-argon/releases
[release-badge]: https://img.shields.io/github/v/release/jerrykuku/luci-theme-argon?style=flat-square
[download]: https://github.com/jerrykuku/luci-theme-argon/releases
[download-badge]: https://img.shields.io/github/downloads/jerrykuku/luci-theme-argon/total?style=flat-square
[contact]: https://t.me/jerryk6
[contact-badge]: https://img.shields.io/badge/Contact-telegram-blue?style=flat-square
[en-us-link]: /README.md
[zh-cn-link]: /README_ZH.md
[en-us-release-log]: /RELEASE.md
[zh-cn-release-log]: /RELEASE_ZH.md
[config-link]: https://github.com/jerrykuku/luci-app-argon-config/releases
[lede]: https://github.com/coolsnowwolf/lede
[official]: https://github.com/openwrt/openwrt
[immortalwrt]: https://github.com/immortalwrt/immortalwrt



<div align="center">

# Action-Openwrt(openwrt自动编译系统) 

[![license][license-badge]][license]
[![prs][prs-badge]][prs]
[![issues][issues-badge]][issues]
[![release][release-badge]][release]
[![download][download-badge]][download]
[![contact][contact-badge]][contact]

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

## 注意事项
1. nginx默认https同时ttyd终端无法显示

## 配置文件说明
### 23.05版本配置文件
1. nginx+clash.config
使用nginx作为web服务器，同时加入openclash
注意：nginx默认强制使用https(ssl)，需要自行修改
以下为取消https强制跳转
在 /etc/nginx/conf.d 中创建一个 web.conf 文件（web为文件名称，随意）
```yaml
server {
    listen 80 default_server;
    isten [::]:80 default_server;
    server_name _lan;
    include restrict_locally;
    include 'conf.d/*.locations';
    access_log off; # logd openwrt
}    

server {
    listen 443 ssl;
    listen [::]:443 ssl;
    server_name _ssl;
    include 'conf.d/*.locations';
    ssl_certificate '/etc/nginx/conf.d/_lan.crt';
    ssl_certificate_key '/etc/nginx/conf.d/_lan.key';
    ssl_session_cache 'shared:SSL:32k';
    ssl_session_timeout '64m';
    access_log off; # logd openwrt
}
```
以下为内网http，外部使用域名并强制跳转https  
除了上述web.conf外，在创建一个https.conf
```yaml
server {
    listen 80;
    listen [::]:80;
    server_name xxx;    #xxx为域名
    return 302 https://$server_name$request_uri;
}

server {
    listen 443 ssl;
    listen [::]:443 ssl;
    server_name xxx;
    include 'conf.d/*.locations';
   
    ssl_certificate '/etc/nginx/conf.d/_lan.crt';
    ssl_certificate_key '/etc/nginx/conf.d/_lan.key';
    
    ssl_session_cache 'shared:SSL:32k';
    ssl_session_timeout '64m';
    
    ssl_ciphers HIGH:!aNULL:MD5;
    ssl_prefer_server_ciphers on;
    access_log off; # logd openwrt
    }
```
使用https是，ttyd终端需配置ssl，否则在https下无法显示

2. uhttp.config
使用uhttp作为web服务器，默认没有openclash，无需其他设置即可直接使用

## 任务
- [x] 美化readme
- [ ] 
- [ ] 



<!-- <style>
    hr:nth-of-type(1) {
        border-width: 10px 0 0 0 !important;
    }
</style> -->
