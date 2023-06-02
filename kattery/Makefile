TARGET := iphone:clang:14.5:12.0
THEOS_PACKAGE_SCHEME = rootless

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = kattery

kattery_FILES = KATTRootListController.m
kattery_FRAMEWORKS = UIKit
kattery_PRIVATE_FRAMEWORKS = Preferences
kattery_INSTALL_PATH = /Library/PreferenceBundles
kattery_CFLAGS = -fobjc-arc
kattery_LIBRARIES = colorpicker
# kattery_EXTRA_FRAMEWORKS = Cephei CepheiPrefs Alderis

include $(THEOS_MAKE_PATH)/bundle.mk
