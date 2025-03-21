CUSTOM_BUILD_DATE := $(shell date -u +%Y%m%d-%H%M)

RYU_PLATFORM_VERSION := 15.0
RYU_BUILD_VERSION := 1.2
RYU_BUILD_TYPE ?= Community
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

ifeq ($(RYU_GAPPS),true)
RYU_BUILD_VARIANT := Gapps
else
RYU_BUILD_VARIANT := Vanilla
endif

RYU_VERSION := RyuUI-$(RYU_PLATFORM_VERSION)-$(RYU_BUILD_VERSION)-$(RYU_BUILD)-$(RYU_BUILD_TYPE)-$(RYU_BUILD_VARIANT)-$(CUSTOM_BUILD_DATE)

# Ryu-UI Platform Version
PRODUCT_SYSTEM_PROPERTIES += \
    ro.ryu.build.date=$(BUILD_DATE) \
    ro.ryu.device=$(RYU_BUILD) \
    ro.ryu.fingerprint=$(ROM_FINGERPRINT) \
    ro.ryu.version=$(RYU_BUILD_VERSION) \
    ro.ryu.maintainer=$(RYU_MAINTAINER) \
    ro.ryu.build.type=$(RYU_BUILD_TYPE) \
    ro.ryu.build.variant=$(RYU_BUILD_VARIANT)

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
