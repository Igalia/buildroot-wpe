################################################################################
#
# wpebackend-fdo
#
################################################################################

WPEBACKEND_FDO_VERSION = 0.1-prerelease2
WPEBACKEND_FDO_SITE = https://wpewebkit.org/releases
WPEBACKEND_FDO_SOURCE = wpebackend-fdo-$(WPEBACKEND_VERSION).tar.xz
WPEBACKEND_FDO_LICENSE = BSD-2-Clause
WPEBACKEND_FDO_INSTALL_STAGING = YES
WPEBACKEND_FDO_DEPENDENCIES = libegl libglib2 libxkbcommon wayland wpebackend

$(eval $(cmake-package))
