include $(THEOS)/makefiles/common.mk

TWEAK_NAME = SmoothSkip
SmoothSkip_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 Spotify"
include $(THEOS_MAKE_PATH)/aggregate.mk
