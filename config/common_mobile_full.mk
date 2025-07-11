# Inherit common RYUOS stuff
$(call inherit-product, vendor/ryuos/config/common_mobile.mk)

PRODUCT_SIZE := full

# Include RyuOS LatinIME dictionaries
PRODUCT_PACKAGE_OVERLAYS += vendor/ryuos/overlay/dictionaries
PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += vendor/ryuos/overlay/dictionaries
