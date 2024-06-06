---
layout: post
title:  "Useful system settings"
date:   2021-09-05
categories: english
permalink: /system-settings
---

{: #flatpak }
### Moving flatpak to separate partition

Preparations
```
sudo mkdir -p /etc/flatpak/installations.d/
cat > /etc/flatpak/installations.d/extra.conf <<-EOF
[Installation "myFlatpaks"]
Path=/path/to/location/
DisplayName=myFlatpaks Installation
StorageType=harddisk
EOF
```
Reinstallation
```
flatpak remote-add flathub https://flathub.org/repo/flathub.flatpakrepo --installation=myFlatpaks
flatpak remove  com.discordapp.Discord --system
flatpak install com.discordapp.Discord --installation=myFlatpaks
```

Although installation with `--user` should be simplier
