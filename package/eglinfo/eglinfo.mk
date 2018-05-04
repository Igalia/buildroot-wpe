################################################################################
#
# eglinfo
#
################################################################################

EGLINFO_VERSION = 5463b8c34f0e3b2977e8a06ed6c9c316ca05c43b
EGLINFO_SITE = $(call github,KDAB,eglinfo,$(EGLINFO_VERSION))
EGLINFO_DEPENDENCIES = host-pkgconf libegl

define EGLINFO_BUILD_CMDS
	cd $(@D) && $(TARGET_CXX) -std=c++11 -o eglinfo main.cpp \
		$$($(PKG_CONFIG_HOST_BINARY) egl --libs --cflags)
endef

define EGLINFO_INSTALL_TARGET_CMDS
	cd $(@D) && install -Dm755 eglinfo $(TARGET_DIR)/usr/bin/eglinfo
endef

$(eval $(generic-package))
