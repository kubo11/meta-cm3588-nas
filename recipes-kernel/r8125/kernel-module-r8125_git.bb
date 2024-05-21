DESCRIPTION = "Realtek out-of-tree driver for r8125"
LICENSE = "GPL-2.0-only"
LIC_FILES_CHKSUM = "file://../LICENSE;md5=b234ee4d69f5fce4486a80fdaf4a4263"

SRCBRANCH = "master"
SRC_URI = "git://github.com/awesometic/realtek-r8125-dkms.git;protocol=https;branch=${SRCBRANCH}"
SRCREV = "980736e3d5bcbb32bee8f1bd228a166dbd2d89f0"

S = "${WORKDIR}/git/src"

DEPENDS = "virtual/kernel"

inherit module

CLEANBROKEN = "1"
MAKE_TARGETS = "-C ${STAGING_KERNEL_DIR} M=${S} modules"
MODULES_INSTALL_TARGET = "-C ${STAGING_KERNEL_DIR} M=${S} modules_install"

FILES:${PN} += "${nonarch_base_libdir}/modules/${KERNEL_VERSION}/extra/modules.order.*"
