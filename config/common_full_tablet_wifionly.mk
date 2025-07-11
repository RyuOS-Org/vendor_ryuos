# Inherit mobile full common RYUOS stuff
$(call inherit-product, vendor/ryuos/config/common_mobile_full.mk)

# Inherit tablet common RYUOS stuff
$(call inherit-product, vendor/ryuos/config/tablet.mk)

$(call inherit-product, vendor/ryuos/config/wifionly.mk)
