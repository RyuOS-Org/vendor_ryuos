# Inherit mobile full common RYUOS stuff
$(call inherit-product, vendor/ryuos/config/common_mobile_full.mk)

# Enable support of one-handed mode
PRODUCT_PRODUCT_PROPERTIES += \
    ro.support_one_handed_mode=true

$(call inherit-product, vendor/ryuos/config/telephony.mk)
