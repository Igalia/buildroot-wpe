################################################################################
#
# dinghy
#
################################################################################

DINGHY_VERSION = ed347cb633aceb7838867dd96761b4ec7dcdfcfa
DINGHY_SITE = $(call github,aperezdc,dinghy,$(DINGHY_VERSION))
DINGHY_DEPENDENCIES += libegl libgles libglib2 libxkbcommon wayland wpebackend wpebackend-fdo wpewebkit
DINGHY_LICENSE = MIT
DINGHY_LICENSE_FILES = COPYING

$(eval $(cmake-package))
