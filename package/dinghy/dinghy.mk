################################################################################
#
# dinghy
#
################################################################################

DINGHY_VERSION = 9231eda3139fce418f707d26cc1439ac0729703a
DINGHY_SITE = $(call github,aperezdc,dinghy,$(DINGHY_VERSION))
DINGHY_DEPENDENCIES += libegl libgles libglib2 libxkbcommon wayland wpebackend wpebackend-fdo wpewebkit
DINGHY_LICENSE = MIT
DINGHY_LICENSE_FILES = COPYING

$(eval $(cmake-package))
