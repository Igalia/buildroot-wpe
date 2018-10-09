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
LIBWPE_CONF_OPTS += \
    -DCMAKE_C_FLAGS="$(TARGET_CFLAGS) -D_GNU_SOURCE" \
    -DCMAKE_CXX_FLAGS="$(TARGET_CXXFLAGS) -D_GNU_SOURCE"

$(eval $(cmake-package))
