################################################################################
#
# cog
#
################################################################################

COG_VERSION = 063df115456a24e464d1e6f284df22a0e65aea8e
COG_SITE = $(call github,Igalia,cog,$(COG_VERSION))
COG_DEPENDENCIES = libglib2 libwpe wpewebkit
COG_LICENSE = MIT
COG_LICENSE_FILES = COPYING
COG_CONF_OPTS = \
	-DCOG_HOME_URI='$(call qstrip,$(BR2_PACKAGE_COG_PROGRAMS_HOME_URI))'

ifeq ($(BR2_PACKAGE_COG_PLATFORM_FDO),y)
COG_DEPENDENCIES += libegl libgles wayland wpebackend-fdo
COG_CONF_OPTS += -DCOG_PLATFORM_FDO=ON
else
COG_CONF_OPTS += -DCOG_PLATFORM_FDO=OFF
endif

ifeq ($(BR2_PACKAGE_COG_PROGRAMS),y)
COG_CONF_OPTS += -DCOG_BUILD_PROGRAMS=ON
else
COG_CONF_OPTS += -DCOG_BUILD_PROGRAMS=OFF
endif

ifeq ($(BR2_PACKAGE_COG_PROGRAMS_DBUS_SYSTEM_BUS),y)
COG_CONF_OPTS += -DCOG_DBUS_SYSTEM_BUS=ON
else
COG_CONF_OPTS += -DCOG_DBUS_SYSTEM_BUS=OFF
endif

$(eval $(cmake-package))
