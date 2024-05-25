DESCRIPTION = "Realtek out-of-tree driver for r8125"
LICENSE = "GPL-2.0-only"
LIC_FILES_CHKSUM = "file://README;md5=c94efb9cfe5969ee6c19b70034d45d69"

# The driver in awesometic repo is unstable on CM3588 NAS. Frequent link down/ups.
#SRCBRANCH = "master"
#SRC_URI = "git://github.com/awesometic/realtek-r8125-dkms.git;protocol=https;branch=${SRCBRANCH}"
#SRCREV = "980736e3d5bcbb32bee8f1bd228a166dbd2d89f0"

SRCBRANCH = "main"
SRC_URI = "git://github.com/friendlyarm/r8125.git;protocol=https;branch=${SRCBRANCH}"
SRCREV = "c4cb053bff438fac317e2371cce45985098e4c49"

S = "${WORKDIR}/git"

DEPENDS = "virtual/kernel"

inherit module

CLEANBROKEN = "1"
MAKE_TARGETS = "-C ${STAGING_KERNEL_DIR} M=${S} modules"
MODULES_INSTALL_TARGET = "-C ${STAGING_KERNEL_DIR} M=${S} modules_install"

FILES:${PN} += "${nonarch_base_libdir}/modules/${KERNEL_VERSION}/extra/modules.order.*"
