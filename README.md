# meta-cm3588-nas

Yocto BSP layer for [FriendlyElec CM3588 NAS](https://www.friendlyelec.com/index.php?route=product/product&product_id=294).

Based on upstream: https://git.yoctoproject.org/meta-rockchip

## Configure Yocto/OE

In order to build an image, you need to download some layers:

```shell
~ $ mkdir yocto; cd yocto
~/yocto $ git clone git://git.yoctoproject.org/poky -b scarthgap --depth 1
~/yocto $ git clone git://git.yoctoproject.org/meta-arm -b scarthgap --depth 1
~/yocto $ git clone git://git.openembedded.org/meta-openembedded.git -b scarthgap --depth 1
~/yocto $ git clone https://github.com/JonLech/meta-cm3588-nas
```

Then you need to source the configuration script:

```shell
~/yocto $ source poky/oe-init-build-env
```

Finally, add layers to build/conf/bblayers.conf.

For example:

```makefile
# build/conf/bblayers.conf
BBLAYERS ?= " \
  ${TOPDIR}/../meta-cm3588-nas \
  ${TOPDIR}/../meta-arm/meta-arm \
  ${TOPDIR}/../meta-arm/meta-arm-toolchain \
  ${TOPDIR}/../poky/meta \
  ${TOPDIR}/../poky/meta-poky \
  ${TOPDIR}/../poky/meta-yocto-bsp \
  ${TOPDIR}/../meta-openembedded/meta-oe \
  "
```

## Building

```
~/yocto $ MACHINE=nanopc-nas bitbake core-image-full-cmdline
```

Build output directory: build/tmp/deploy/images/nanopc-nas

## Flashing device (eMMC)

To flash the device you will need rkdeveloptool: https://github.com/rockchip-linux/rkdeveloptool

With power off and the USB-C on the CM3588 NAS connected to your Mac/PC, hold the [mask button](https://www.friendlyelec.com/image/catalog/description/CM3588_en_05.jpg) and connect power to the device.

Verify that the device appears in maskrom mode:

```shell
$ rkdeveloptool ld
DevNo=1	Vid=0x2207,Pid=0x350b,LocationID=802	Maskrom
```

Build the RK3588 loader:

```shell
git clone https://github.com/rockchip-linux/rkbin --depth 1
(cd rkbin; ./tools/boot_merger RKBOOT/RK3588MINIALL.ini)
```

Push the loader to the device:

```shell
$ rkdeveloptool db rkbin/rk3588_spl_loader_v1.16.113.bin
$ rkdeveloptool ul rkbin/rk3588_spl_loader_v1.16.113.bin
```

Flash the image to the device:

```shell
$ rkdeveloptool wl 0 core-image-full-cmdline-nanopc-nas.rootfs.wic
```

Reboot device:

```shell
$ rkdeveloptool rd
```