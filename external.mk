define virtualize-one-package

$(2)_ADD_TOOLCHAIN_DEPENDENCY = NO
$(2)_REDISTRIBUTE = NO
$(2)_INSTALL_IMAGES = NO
$(2)_INSTALL_TARGET = NO
$(2)_INSTALL_STAGING = NO
$(2)_DEPENDENCIES += $(3)

# Ugh. We cannot set _SITE_METHOD=local and point to an empty
# directory, so we provide an alternative set of commands for
# a virtualized package which do nothings, plus resets for
# variables used during build/install.

$(2)_EXTRACT_CMDS               = @true
$(2)_CONFIGURE_CMDS             = @true
$(2)_BUILD_CMDS                 = @true
$(2)_INSTALL_CMDS               = @true
$(2)_INSTALL_STAGING_CMDS       = @true
$(2)_INSTALL_TARGET_CMDS        = @true
$(2)_INSTALL_IMAGES_CMDS        = @true
$(2)_INSTALL_INIT_SYSTEMD       = @true
$(2)_INSTALL_INIT_BUSYBOX       = @true
$(2)_INSTALL_INIT_SYSV          = @true
$(2)_ALL_DOWNLOADS              =
$(2)_HELP_CMDS                  =
$(2)_CONFIG_SCRIPTS             =
$(2)_LICENSE_FILES              =
$(2)_MANIFEST_LICENSE_FILES     =

# Clear hooks as well.
$(2)_PRE_DOWNLOAD_HOOKS         =
$(2)_POST_DOWNLOAD_HOOKS        =
$(2)_PRE_EXTRACT_HOOKS          =
$(2)_POST_EXTRACT_HOOKS         =
$(2)_PRE_RSYNC_HOOKS            =
$(2)_POST_RSYNC_HOOKS           =
$(2)_PRE_PATCH_HOOKS            =
$(2)_POST_PATCH_HOOKS           =
$(2)_PRE_CONFIGURE_HOOKS        =
$(2)_POST_CONFIGURE_HOOKS       =
$(2)_PRE_BUILD_HOOKS            =
$(2)_POST_BUILD_HOOKS           =
$(2)_PRE_INSTALL_HOOKS          =
$(2)_POST_INSTALL_HOOKS         =
$(2)_PRE_INSTALL_STAGING_HOOKS  =
$(2)_POST_INSTALL_STAGING_HOOKS =
$(2)_PRE_INSTALL_TARGET_HOOKS   =
$(2)_POST_INSTALL_TARGET_HOOKS  =
$(2)_PRE_INSTALL_IMAGES_HOOKS   =
$(2)_POST_INSTALL_IMAGES_HOOKS  =
$(2)_PRE_LEGAL_INFO_HOOKS       =
$(2)_POST_LEGAL_INFO_HOOKS      =
$(2)_TARGET_FINALIZE_HOOKS      =
$(2)_ROOTFS_PRE_CMD_HOOKS       =
$(2)_ROOTFS_POST_CMD_HOOKS      =

# The patching phase is controlled by a target-local variable. Clear.
$$($(2)_DIR)/.stamp_patched: PATCH_BASE_DIRS =

# The following allow using "make legal-info" by emptying the list of
# source files, and creating an empty patch series file so the legal-info
# rules won't complain about it missing.

ifeq ($(strip $(findstring legal-info,$(MAKECMDGOALS))),legal-info)

$(2)_SOURCE =

$(1)-legal-source: $($(2)_DIR)/.applied_patches_list

$$($(2)_DIR)/.applied_patches_list:
	@touch $$@

endif

endef

define virtualize-packages
ifeq ($$($(call UPPERCASE,$(pkgname))_VIRTUALIZES),)
$$(error No packages chosen to be virtualized by $(pkgname))
endif
$(foreach PKG,$($(call UPPERCASE,$(pkgname))_VIRTUALIZES),$(call virtualize-one-package,$(PKG),$(call UPPERCASE,$(PKG)),$(pkgname)))
endef

# Include all package build recipes from the overlay.
include $(sort $(wildcard $(BR2_EXTERNAL_WPE_RPI_PATH)/package/*/*.mk))

# Always build host-file so it can be used by the tools/can-strip script.
PACKAGES += host-file
