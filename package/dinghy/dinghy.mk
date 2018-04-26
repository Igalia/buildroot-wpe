################################################################################
#
# dinghy
#
################################################################################

DINGHY_VERSION = d9a0716dd476faebaeca1daebc32a2ccad17bf2b
DINGHY_SITE = $(call github,aperezdc,dinghy,$(DINGHY_VERSION))
DINGHY_DEPENDENCIES += wpewebkit
DINGHY_LICENSE = MIT
DINGHY_LICENSE_FILES = COPYING

$(eval $(cmake-package))
