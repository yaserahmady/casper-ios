export GO_EASY_ON_ME    = 1
include $(THEOS)/makefiles/common.mk

TOOL_NAME               = casper
ARCHS                   = arm64 arm64e
SYSROOT                 = $(THEOS)/sdks/iPhoneOS13.0.sdk

casper_INSTALL_PATH = /usr/bin
casper_FRAMEWORKS   = Foundation

casper_FILES        = main.xm
casper_CFLAGS       = -fobjc-arc

include $(THEOS_MAKE_PATH)/tool.mk