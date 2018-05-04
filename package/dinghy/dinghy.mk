################################################################################
#
# dinghy
#
################################################################################

DINGHY_VERSION = dae960109bf29cea37e0ac61931275243d099659
DINGHY_SITE = $(call github,aperezdc,dinghy,$(DINGHY_VERSION))
DINGHY_DEPENDENCIES += libegl libgles libglib2 libxkbcommon wayland wpebackend wpebackend-fdo wpewebkit
DINGHY_LICENSE = MIT
DINGHY_LICENSE_FILES = COPYING

$(eval $(cmake-package))
