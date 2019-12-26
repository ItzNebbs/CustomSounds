ARCHS = arm64
FINALPACKAGE = 1

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = CustomSounds
$(TWEAK_NAME)_FILES = $(wildcard *.xm *.m)
$(TWEAK_NAME)_FRAMEWORKS = UIKit CoreGraphics AVFoundation AudioToolbox
$(TWEAK_NAME)_LDFLAGS += -lCSPreferencesProvider
$(TWEAK_NAME)_CFLAGS = -Wno-error -Wno-return-type -Wno-objc-method-access -Wno-objc-property-no-attribute -Wno-deprecated -Wno-deprecated-declarations -Wno-incomplete-umbrella

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += customsounds
include $(THEOS_MAKE_PATH)/aggregate.mk
