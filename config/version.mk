PRODUCT_VERSION_MAJOR = 1
PRODUCT_VERSION_MINOR = 2

CURRENT_DEVICE=$(shell echo "$(TARGET_PRODUCT)" | cut -d'_' -f 2,3)

RYU_BUILDTYPE ?= COMMUNITY
RYU_MAINTAINER ?= Wakaranai?

OFFICIAL_MAINTAINER = $(shell cat vendor/ryu/maintainer/official_maintainer.mk | awk '{ print $$1 }')

# Official maintainer
ifdef RYU_MAINTAINER
        ifeq ($(filter $(RYU_MAINTAINER), $(OFFICIAL_MAINTAINER)), $(RYU_MAINTAINER))
                $(warning "$(RYU_MAINTAINER) is verified as official maintainer, build as official build.")
                RYU_BUILD_TYPE := OFFICIAL
        else
                $(warning "Unofficial maintainer detected, building as COMMUNITY build.")
        endif
else
        $(warning "No maintainer name detected, building as COMMUNITY build.")
endif

RYU_VERSION := RyuUI-v$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(CURRENT_DEVICE)-$(RYU_BUILDTYPE)-$(shell date -u +%Y%m%d-%H%M)

# Display version
RYU_DISPLAY_VERSION := v$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)

# The Ryu-UI Project version properties
PRODUCT_SYSTEM_PROPERTIES += \
    ro.ryu.version=$(RYU_VERSION) \
    ro.ryu.device=$(RYU_BUILD) \
    ro.ryu.display.version=$(RYU_DISPLAY_VERSION) \
    ro.ryu.build.version=$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR) \
    ro.ryu.releasetype=$(RYU_BUILDTYPE) \
    ro.ryu.maintainer=$(RYU_MAINTAINER)
