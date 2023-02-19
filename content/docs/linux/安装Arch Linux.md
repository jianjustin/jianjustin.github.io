# 安装Arch Linux

## 最小系统安装

1. 检查引导方式是否是EFI：`ls /sys/firmware/efi/efivars`
2. 创建引导分区（EFI方式需要，BIOS方式可跳过）
   1. 检查当前磁盘情况： `fdisk -l`
   2. 创建分区：`fdisk /dev/sda`
   3. 输入g创建新gpt分区表，输入n创建新分区，输入+512M来创建512M引导分区
   4. 格式化分区：`mkfs.fat /dev/sda1`
   5. 输入w使分区生效
3. 创建根分区
   1. 创建分区：`fdisk /dev/sda`
   2. 输入o创建MBR分区表，输入n创建新分区
   3. 格式化分区：`mkfs.ext4 /dev/sda2`
   4. 输入w使分区生效
4. 挂载分区
   1. 挂载根分区：`mount /dev/sda1 /mnt`
   2. 挂载引导分区：`mkdir /mnt/boot && mount /dev/sda2 /mnt/boot`
5. 修改镜像源：`vim /etc/pacman.d/mirrorlist`
6. 安装基本包：`pacstrap /mnt base base-devel linux linux-firmware dhcpcd`
7. 配置Fstab：`genfstab -L /mnt >> /mnt/etc/fstab && cat /mnt/etc/fstab`
8. 进入最小系统：`arch-chroot /mnt`

## 系统配置

1. 安装必要依赖：`pacman -S vim dialog wpa_supplicant ntfs-3g networkmanager netctl`
2. 设置时区：`ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && hwclock —-systohc`
3. 设置语言包： `vim /etc/locale.gen && locale-gen`配置`zh_CN.UTF-8 UTF-8,zh_HK.UTF-8 UTF-8,zh_TW.UTF-8 UTF-8,en_US.UTF-8 UTF-8`
4. 配置字符集：`locale - vim /etc/locale.conf`在文件第一行配置`LANG=en_US.UTF-8`
5. 配置主机名 ：`vim /etc/hostname`
6. 配置hosts ：`vim /etc/hosts`

```shell
127.0.0.1 localhost
::1 localhost
127.0.1.1 myhostname.localdomain myhostname
```

7. 配置root密码： `passwd`
8. 安装intel固件：`pacman -S intel-ucode`
9. 安装bootloader
   1. 安装必要配置： `pacman -S os-prober ntfs-3g grub`
   2. 部署grub： `grub-install —-target=i386-pc /dev/sda`
   3. 生成配置文件： `grub-mkconfig -o /boot/grub/grub.cfg`
10. 卸载最小系统并重启

```shell
exit
umount /mnt
reboot
```

## 安装图形化

1. 安装显卡驱动： `sudo pacman -S xf86-video-intel`
2. 安装xorg： `sudo pacman -S xorg`
3. 安装KDE桌面环境： `sudo pacman -S plasma kde-applications`
4. 安装桌面管理器sddm： `sudo pacman -S sddm`
5. 设置开机启动： `sudo systemctl enable sddm`

 [参考](https://www.viseator.com/2017/05/17/arch_install/) 