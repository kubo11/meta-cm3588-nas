FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:nanopc-nas = " \
       git://github.com/Kwiboo/u-boot-rockchip.git;protocol=https;branch=rk3xxx-2024.07 \
       file://0001-Add-nanopc-nas-rk3588-board.patch \
       "
SRCREV:nanopc-nas = "${AUTOREV}"

# various machines require the pyelftools library for parsing dtb files
DEPENDS:append = " python3-pyelftools-native"
DEPENDS:append:rk3308 = " u-boot-tools-native"
DEPENDS:append:rock-pi-4 = " gnutls-native"

EXTRA_OEMAKE:append:px30 = " BL31=${DEPLOY_DIR_IMAGE}/bl31-px30.elf"
EXTRA_OEMAKE:append:rk3308 = " \
	BL31=${DEPLOY_DIR_IMAGE}/bl31-rk3308.elf \
	ROCKCHIP_TPL=${DEPLOY_DIR_IMAGE}/ddr-rk3308.bin \
	"
EXTRA_OEMAKE:append:rk3328 = " BL31=${DEPLOY_DIR_IMAGE}/bl31-rk3328.elf"
EXTRA_OEMAKE:append:rk3399 = " BL31=${DEPLOY_DIR_IMAGE}/bl31-rk3399.elf"
EXTRA_OEMAKE:append:rk3568 = " \
	BL31=${DEPLOY_DIR_IMAGE}/bl31-rk3568.elf \
	ROCKCHIP_TPL=${DEPLOY_DIR_IMAGE}/ddr-rk3568.bin \
	"
EXTRA_OEMAKE:append:rk3588s = " \
	BL31=${DEPLOY_DIR_IMAGE}/bl31-rk3588.elf \
	ROCKCHIP_TPL=${DEPLOY_DIR_IMAGE}/ddr-rk3588.bin \
	"

INIT_FIRMWARE_DEPENDS ??= ""
INIT_FIRMWARE_DEPENDS:px30 = " trusted-firmware-a:do_deploy"
INIT_FIRMWARE_DEPENDS:rk3308 = " ${@bb.utils.contains('RKBIN_RK3308_LATEST', '1', 'rockchip-rkbin', 'rk3308-rkbin', d)}:do_deploy"
INIT_FIRMWARE_DEPENDS:rk3328 = " trusted-firmware-a:do_deploy"
INIT_FIRMWARE_DEPENDS:rk3399 = " trusted-firmware-a:do_deploy"
INIT_FIRMWARE_DEPENDS:rk3568 = " rockchip-rkbin:do_deploy"
INIT_FIRMWARE_DEPENDS:rk3588s = " rockchip-rkbin:do_deploy"
do_compile[depends] .= "${INIT_FIRMWARE_DEPENDS}"

do_compile:append:rock2-square () {
	# copy to default search path
	if [ "${SPL_BINARY}" = "u-boot-spl-dtb.bin" ]; then
		cp ${B}/spl/${SPL_BINARY} ${B}
	fi
}
