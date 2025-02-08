CUSTOM_BUILD_DATE := $(shell date -u +%Y%m%d-%H%M)

RYU_PLATFORM_VERSION := 15.0
RYU_DISPLAY_VERSION := Ryujin
RYU_BUILD_TYPE ?= Unofficial
RYU_MAINTAINER ?= Wakaranai?

OFFICIAL_MAINTAINER = $(shell cat vendor/ryu/maintainer/official_maintainer.mk | awk '{ print $$1 }')

# Official maintainer
ifdef RYU_MAINTAINER
        ifeq ($(filter $(RYU_MAINTAINER), $(OFFICIAL_MAINTAINER)), $(RYU_MAINTAINER))
                $(warning "$(RYU_MAINTAINER) is verified as official maintainer, build as official build.")
                RYU_BUILD_TYPE := Official
        else
                $(warning "Unofficial maintainer detected, building as unofficial build.")
        endif
else
        $(warning "No maintainer name detected, building as unofficial build.")
endif

RYU_VERSION := RyuUI-$(RYU_DISPLAY_VERSION)-$(RYU_BUILD)-$(RYU_BUILD_TYPE)-$(RYU_PLATFORM_VERSION)-$(CUSTOM_BUILD_DATE)

# Ryu-UI Platform Version
PRODUCT_SYSTEM_PROPERTIES += \
    ro.ryu.build.date=$(BUILD_DATE) \
    ro.ryu.device=$(RYU_BUILD) \
    ro.ryu.fingerprint=$(ROM_FINGERPRINT) \
    ro.ryu.version=$(RYU_DISPLAY_VERSION) \
    ro.modversion=$(RYU_VERSION) \
    ro.ryu.maintainer=$(RYU_MAINTAINER) \
    ro.ryu.build.type=$(RYU_BUILD_TYPE)

# Signing
ifneq (eng,$(TARGET_BUILD_VARIANT))
ifneq (,$(wildcard vendor/ryu/signing/keys/releasekey.pk8))
PRODUCT_DEFAULT_DEV_CERTIFICATE := vendor/ryu/signing/keys/releasekey
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.oem_unlock_supported=1
endif
ifneq (,$(wildcard vendor/ryu/signing/keys/otakey.x509.pem))
PRODUCT_OTA_PUBLIC_KEYS := vendor/ryu/signing/keys/otakey.x509.pem
endif
endif
