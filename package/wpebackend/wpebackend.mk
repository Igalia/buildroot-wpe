################################################################################
#
# wpebackend
#
################################################################################

WPEBACKEND_VERSION = 0.1-prerelease2
WPEBACKEND_SITE = https://wpewebkit.org/releases
WPEBACKEND_SOURCE = wpebackend-$(WPEBACKEND_VERSION).tar.xz
WPEBACKEND_LICENSE = BSD-2-Clause
WPEBACKEND_INSTALL_STAGING = YES
WPEBACKEND_DEPENDENCIES = libegl

$(eval $(cmake-package))
