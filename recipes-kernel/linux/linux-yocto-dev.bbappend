FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

KBRANCH:nanopc-nas = "nanopi6-v6.1.y"
SRC_URI:nanopc-nas = " \
	git://github.com/friendlyarm/kernel-rockchip.git;branch=${KBRANCH};name=machine;protocol=https \
	git://git.yoctoproject.org/yocto-kernel-cache;type=kmeta;name=meta;branch=master;destsuffix=${KMETA};protocol=https \
	file://rockchip-kmeta;type=kmeta;name=rockchip-kmeta;destsuffix=rockchip-kmeta \
	"
LINUX_VERSION:nanopc-nas = "6.1"

COMPATIBLE_MACHINE:orangepi-5-plus = "orangepi-5-plus"
COMPATIBLE_MACHINE:nanopc-nas = "nanopc-nas"

SRC_URI:append:orangepi-5-plus = " file://rockchip-kmeta;type=kmeta;name=rockchip-kmeta;destsuffix=rockchip-kmeta"
