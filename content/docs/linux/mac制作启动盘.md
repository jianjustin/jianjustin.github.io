# Mac制作启动盘

1. 查看U盘设备ID：`diskutil list`
2. 取消U盘挂载：`disk unmountDisk /dev/disk2`
3. 写入镜像：`sudo dd if=/Users/{username}/Downloads/CentOS.iso of=/dev/disk2 bs=1m`