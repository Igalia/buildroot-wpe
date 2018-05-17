################################################################################
#
# cog
#
################################################################################

COG_VERSION = c6d96edc60e57c728d3f6751d6a5b9e84b6f7d5a
COG_SITE = $(call github,Igalia,cog,$(COG_VERSION))
COG_DEPENDENCIES = wpebackend wpewebkit
COG_LICENSE = MIT
COG_LICENSE_FILES = COPYING
COG_INSTALL_STAGING = YES
COG_CONF_OPTS = -DCOG_USE_WEBKITGTK=OFF -DCOG_DBUS_SYSTEM_BUS=OFF

ifeq ($(BR2_PACKAGE_COG_PLATFORM_FDO),y)
COG_DEPENDENCIES += wpebackend-fdo
COG_CONF_OPTS += -DCOG_PLATFORM_FDO=ON
else
COG_CONF_OPTS += -DCOG_PLATFORM_FDO=OFF
endif

$(eval $(cmake-package))
