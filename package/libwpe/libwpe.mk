################################################################################
#
# libwpe
#
################################################################################

LIBWPE_VERSION = 1.0.0
LIBWPE_SITE = https://wpewebkit.org/releases
LIBWPE_SOURCE = libwpe-$(LIBWPE_VERSION).tar.xz
LIBWPE_LICENSE = BSD-2-Clause
LIBWPE_INSTALL_STAGING = YES
LIBWPE_DEPENDENCIES = libegl libxkbcommon

$(eval $(cmake-package))
