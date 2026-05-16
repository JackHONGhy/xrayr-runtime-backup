# XrayR Automated Install Script

这个项目用于保存一份可直接恢复安装的 XrayR 0.9.4 运行包，并提供一键安装脚本。

它不是 XrayR 官方源码仓库，而是一个已经整理好的运行环境备份包，适合把 XrayR 快速安装到新的 Linux 服务器上。

## 支持架构

- Linux amd64 / x86_64
- Linux arm64 / aarch64

安装脚本会自动读取服务器架构，并下载对应版本：

- `x86_64` / `amd64` 使用 `xrayr-0.9.4-linux-amd64-default-config.tar.gz`
- `aarch64` / `arm64` 使用 `xrayr-0.9.4-linux-arm64-default-config.tar.gz`

## 一键安装

在目标服务器上使用 root 用户运行：

```bash
bash <(curl -Ls https://raw.githubusercontent.com/JackHONGhy/xrayr-automated-install-script/master/install.sh)
```

脚本会自动完成：

- 检测当前系统 CPU 架构
- 显示识别到的系统架构和即将安装的对应架构版本
- 下载对应架构的 XrayR 运行包
- 校验运行包 SHA256
- 解压文件到 `/usr/local/XrayR` 和 `/etc/XrayR`
- 安装 `XrayR.service`
- 安装 `XrayR` / `xrayr` 管理命令
- 设置 systemd 开机自启

## 安装后配置

安装完成后，先编辑配置文件：

```bash
nano /etc/XrayR/config.yml
```

配置完成后启动服务：

```bash
systemctl start XrayR
```

查看运行状态：

```bash
systemctl status XrayR --no-pager -l
```

查看日志：

```bash
journalctl -u XrayR.service -e --no-pager -f
```

也可以使用管理命令：

```bash
xrayr
```

## 本项目做过的修改

- 从原来的单 amd64 安装包扩展为 amd64 + arm64 双架构安装包
- 新增 ARM64 / AArch64 运行包
- 修改 `install.sh`，自动识别 `x86_64/amd64` 和 `aarch64/arm64`
- 为不同架构配置独立 SHA256 校验
- 保留原来的 XrayR 管理脚本行为，让 `xrayr` 命令进入管理菜单
- 保留 systemd 服务方式，服务入口为 `/usr/local/XrayR/XrayR --config /etc/XrayR/config.yml`

## 文件说明

- `install.sh`：一键安装脚本，自动识别架构
- `xrayr-0.9.4-linux-amd64-default-config.tar.gz`：Linux amd64 运行包
- `xrayr-0.9.4-linux-arm64-default-config.tar.gz`：Linux arm64 运行包
- `xrayr-manager.sh`：XrayR 管理菜单脚本

## 校验值

- amd64 SHA256：`2376ab435eee70e31b9553423865f37289b3e438bb79f01f90f7b49ea91825ff`
- arm64 SHA256：`43fdc96a9ff6362bbf3d917ff5adcfb856e67d3d44615a5bed6cf6ea84e30e64`

## 手动恢复

如果不使用一键脚本，也可以手动解压对应架构的包：

```bash
tar -xzf xrayr-0.9.4-linux-amd64-default-config.tar.gz -C /
systemctl daemon-reload
systemctl enable XrayR
systemctl start XrayR
```

ARM64 服务器请把压缩包文件名换成：

```bash
xrayr-0.9.4-linux-arm64-default-config.tar.gz
```
