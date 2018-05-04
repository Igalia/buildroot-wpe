################################################################################
#
# wpewebkit
#
################################################################################

WPEWEBKIT_VERSION = 0.19.0-prerelease1
WPEWEBKIT_SITE = https://www.wpewebkit.org/releases
WPEWEBKIT_SOURCE = wpewebkit-$(WPEWEBKIT_VERSION).tar.xz
WPEWEBKIT_INSTALL_STAGING = YES
WPEWEBKIT_LICENSE = LGPv2.1+, BSD-2-Clause
WPEWEBKIT_LICENSE_FILES = \
	Source/WebCore/LICENSE-APPLE \
	Source/WebCore/LICENSE-LGPL-2.1
WPEWEBKIT_DEPENDENCIES = host-cmake host-ruby host-flex host-bison \
	host-gperf harfbuzz icu jpeg libegl libepoxy libgcrypt libsoup \
	libxml2 sqlite webp wpebackend
WPEWEBKIT_CONF_OPTS = \
	-DPORT=WPE \
	-DUSE_WOFF2=OFF

# JSC JIT is supported on: i386, x86_64, aarch64 and mips32le target archs.
# For target arch arm (32) it is only supported on ARMv7 CPUs and ARMv8 CPUs,
# and is recommended to generate a Thumb2 build (as upstream tests more this)
ifeq ($(BR2_i386)$(BR2_x86_64)$(BR2_aarch64)$(BR2_mipsel),y)
WPEWEBKIT_CONF_OPTS += -DENABLE_JIT=ON
else ifeq ($(BR2_ARM_CPU_ARMV7A)$(BR2_ARM_CPU_ARMV8A)$(BR2_ARM_CPU_ARMV8),y)
WPEWEBKIT_CONF_OPTS += -DENABLE_JIT=ON
else
WPEWEBKIT_CONF_OPTS += -DENABLE_JIT=OFF
endif

ifeq ($(BR2_PACKAGE_WPEWEBKIT_MULTIMEDIA),y)
WPEWEBKIT_CONF_OPTS += \
	-DENABLE_VIDEO=ON \
	-DENABLE_WEB_AUDIO=ON
WPEWEBKIT_DEPENDENCIES += gstreamer1 gst1-libav gst1-plugins-base \
	gst1-plugins-good gst1-plugins-bad
else
WPEWEBKIT_CONF_OPTS += \
	-DENABLE_VIDEO=OFF \
	-DENABLE_WEB_AUDIO=OFF
endif

ifeq ($(BR2_PACKAGE_WPEWEBKIT_HTTPS),y)
WPEWEBKIT_DEPENDENCIES += glib-networking
endif

ifeq ($(BR2_PACKAGE_WPEWEBKIT_WEBCRYPTO),y)
WPEWEBKIT_CONF_OPTS += -DENABLE_WEB_CRYPTO=ON
WPEWEBKIT_DEPENDENCIES += libtasn1
else
WPEWEBKIT_CONF_OPTS += -DENABLE_WEB_CRYPTO=OFF
endif

ifeq ($(BR2_PACKAGE_WPEWEBKIT_WEBDRIVER),y)
WPEWEBKIT_CONF_OPTS += -DENABLE_WEBDRIVER=ON
else
WPEWEBKIT_CONF_OPTS += -DENABLE_WEBDRIVER=OFF
endif

ifeq ($(BR2_PACKAGE_WPEWEBKIT_XSLT),y)
WPEWEBKIT_CONF_OPTS += -DENABLE_XSLT=ON
WPEWEBKIT_DEPENDENCIES += libxslt
else
WPEWEBKIT_CONF_OPTS += -DENABLE_XSLT=OFF
endif

define WPEWEBKIT_BUILD_JSC
	$(WPEWEBKIT_MAKE_ENV) $(WPEWEBKIT_MAKE) -C $(@D) jsc
endef

define WPEWEBKIT_INSTALL_JSC
	install -Dm755 $(@D)/bin/jsc $(TARGET_DIR)/usr/bin/jsc
	$(STRIPCMD) $(TARGET_DIR)/usr/bin/jsc
endef

define WPEWEBKIT_INSTALL_JSC_STAGING
	install -Dm755 $(@D)/bin/jsc $(STAGING_DIR)/usr/bin/jsc
	cd $(@D) && DESTDIR=$(STAGING_DIR) $(HOST_DIR)/usr/bin/cmake \
			-DCOMPONENT=Development \
			-P $(WPEWEBKIT_BUILDDIR)/Source/JavaScriptCore/cmake_install.cmake
endef

ifeq ($(BR2_PACKAGE_WPEWEBKIT_BUILD_JSC),y)
WPEWEBKIT_POST_BUILD_HOOKS += WPEWEBKIT_BUILD_JSC
WPEWEBKIT_POST_INSTALL_TARGET_HOOKS += WPEWEBKIT_INSTALL_JSC
WPEWEBKIT_POST_INSTALL_STAGING_HOOKS += WPEWEBKIT_INSTALL_JSC_STAGING
endif

$(eval $(cmake-package))
