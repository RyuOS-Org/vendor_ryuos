# RYUOS STUFF HERE
ANDROID_VERSION := 16
RYUOS_CODENAME_VERSION := Celestia
RYUOS_BUILD_ROM_TYPE := VANILLA

RYUOS_MAINTAINER ?= Idk
RYUOS_BUILD_TYPE ?= UNOFFICIAL
RYUOS_DATE_YEAR := $(shell date -u +%Y)
RYUOS_DATE_MONTH := $(shell date -u +%m)
RYUOS_DATE_DAY := $(shell date -u +%d)
RYUOS_DATE_HOUR := $(shell date -u +%H)
RYUOS_DATE_MINUTE := $(shell date -u +%M)
RYUOS_BUILD_DATE := $(RYUOS_DATE_YEAR)$(RYUOS_DATE_MONTH)$(RYUOS_DATE_DAY)-$(RYUOS_DATE_HOUR)$(RYUOS_DATE_MINUTE)
TARGET_PRODUCT_SHORT := $(subst ryu_,,$(RYUOS_BUILD))

# GAPPS
WITH_GAPPS ?= false
ifeq ($(WITH_GAPPS), true)
    ifeq ($(WITH_GAPPS_GO), true)
        $(call inherit-product, vendor/partner_gms/products/gms_go_2gb.mk)
    else
        $(call inherit-product, vendor/partner_gms/products/gms.mk)
    endif
    RYUOS_BUILD_ROM_TYPE := GAPPS
endif

# OFFICIAL_DEVICES
ifeq ($(RYUOS_BUILD_TYPE), OFFICIAL)
  LIST = $(shell cat vendor/ryuos/ryuos.devices)
    ifeq ($(filter $(RYUOS_BUILD), $(LIST)), $(RYUOS_BUILD))
      IS_OFFICIAL=true
      RYUOS_BUILD_TYPE := OFFICIAL
    endif
    ifneq ($(IS_OFFICIAL), true)
      RYUOS_BUILD_TYPE := UNOFFICIAL
      $(error Device is not official "$(RYUOS_BUILD)")
    endif
endif

RYUOS_VERSION := $(RYUOS_CODENAME_VERSION)-$(RYUOS_BUILD)-$(RYUOS_BUILD_DATE)-$(RYUOS_BUILD_TYPE)-$(RYUOS_BUILD_ROM_TYPE)
RYUOS_MOD_VERSION :=$(ANDROID_VERSION)-$(RYUOS_CODENAME_VERSION)
RYUOS_DISPLAY_VERSION := RYUOS-$(RYUOS_CODENAME_VERSION)-$(RYUOS_BUILD_TYPE)-$(RYUOS_BUILD_ROM_TYPE)
RYUOS_DISPLAY_BUILDTYPE := $(RYUOS_BUILD_TYPE)
RYUOS_FINGERPRINT := RYUOS/$(RYUOS_MOD_VERSION)/$(TARGET_PRODUCT_SHORT)/$(RYUOS_BUILD_DATE)
RYUOS_PLATFORM_RELEASE_OR_CODENAME := 16.0

# RYUOS System Version
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
  ro.ryuos.version=$(RYUOS_DISPLAY_VERSION) \
  ro.ryuos.build.status=$(RYUOS_BUILD_TYPE) \
  ro.modversion=$(RYUOS_MOD_VERSION) \
  ro.ryuos.build.date=$(RYUOS_BUILD_DATE) \
  ro.ryuos.buildtype=$(RYUOS_BUILD_TYPE) \
  ro.ryuos.maintainer=$(RYUOS_MAINTAINER) \
  ro.ryuos.fingerprint=$(RYUOS_FINGERPRINT) \
  ro.ryuos.device=$(RYUOS_BUILD) \
  ro.ryuos.platform_release_or_codename=$(RYUOS_PLATFORM_RELEASE_OR_CODENAME) \
  org.ryuos.version=$(RYUOS_CODENAME_VERSION) \
  ro.ryuos.romtype=$(RYUOS_BUILD_ROM_TYPE)
