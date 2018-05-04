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
WPEBACKEND_CONF_OPTS += \
	-DCMAKE_C_FLAGS="$(TARGET_CFLAGS) -D_GNU_SOURCE" \
	-DCMAKE_CXX_FLAGS="$(TARGET_CXXFLAGS) -D_GNU_SOURCE"

$(eval $(cmake-package))
