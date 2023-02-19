# Arch Linux配置Clash

## 安装Clash

- 安装Clash：`sudo pacman -S clash`
- 生成Clash配置文件（配置文件目录是`～/.config/clash`）：`clash`

## 设置终端代理

- 安装proxychains-ng：`sudo pacman -S proxychains-ng`
- 修改配置文件：`sudo vim /etc/proxychains.conf`

```sh
[ProxyList]
# add proxy here ...
# meanwile
# defaults set to "tor"
socks5 	127.0.0.1 7891
```

- 命令走代理：`proxychains <command>`

- 配置环境：`sudo vim /etc/environment`

```sh
http_proxy=127.0.0.1:7890
https_proxy=127.0.0.1:7890
socks_proxy=127.0.0.1:7891
```


## 自启动Clash

- 添加配置文件

```sh
# 创建文件夹用以存储 Clash 相关文件
sudo mkdir -p /etc/clash
# 复制相关文件
sudo cp ~/.config/clash/config.yaml /etc/clash/
sudo cp ~/.config/clash/Country.mmdb /etc/clash/
```

- 添加Clash服务：`sudo vim /etc/systemd/system/clash.service`
```service
[Unit]
Description=Clash daemon, A rule-based proxy in Go.
After=network.target

[Service]
Type=simple
Restart=always
ExecStart=/usr/bin/clash -d /etc/clash # /usr/bin/clash 为绝对路径，请根据你实际情况修改

[Install]
WantedBy=multi-user.target
```

- 添加clash到守护进程：`sudo systemctl enable clash`
- 启动Clash：`sudo systemctl start clash`