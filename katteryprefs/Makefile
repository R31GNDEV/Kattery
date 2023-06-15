TARGET := iphone:clang:14.5:12.0
THEOS_PACKAGE_SCHEME = rootless

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = katteryprefs

katteryprefs_FILES = KATTRootListController.m
katteryprefs_FRAMEWORKS = UIKit
katteryprefs_PRIVATE_FRAMEWORKS = Preferences
katteryprefs_INSTALL_PATH = /Library/PreferenceBundles
katteryprefs_CFLAGS = -fobjc-arc
katteryprefs_LIBRARIES = colorpicker
#katteryprefs_EXTRA_FRAMEWORKS = Alderis

include $(THEOS_MAKE_PATH)/bundle.mk
