TARGET := iphone:clang:14.5:14.0
INSTALL_TARGET_PROCESSES = WeChat
ARCHS = arm64

# 默认无根。SCHEME=rootful | rootless | roothide
# 隐根 deb 架构是 iphoneos-arm64e，但微信只能加载 arm64 Mach-O，所以 ARCHS 固定 arm64。
ifeq ($(SCHEME),roothide)
    export THEOS_PACKAGE_SCHEME = roothide
else ifeq ($(SCHEME),rootful)
    override THEOS_PACKAGE_SCHEME :=
    unexport THEOS_PACKAGE_SCHEME
else
    export THEOS_PACKAGE_SCHEME = rootless
endif

export DEBUG = 0
include $(THEOS)/makefiles/common.mk

TWEAK_NAME = MomentsLikeEgg

$(TWEAK_NAME)_FILES = Tweak.xm
$(TWEAK_NAME)_CFLAGS = -fobjc-arc -Wno-unused-variable
$(TWEAK_NAME)_FRAMEWORKS = Foundation
$(TWEAK_NAME)_LIBRARIES = substrate

include $(THEOS_MAKE_PATH)/tweak.mk

clean::
	@rm -rf .theos

.PHONY: package-all
package-all:
	@bash ./package-all.sh
