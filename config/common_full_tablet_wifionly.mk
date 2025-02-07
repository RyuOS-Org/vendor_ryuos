# Inherit mobile full common stuff
$(call inherit-product, vendor/ryu/config/common_mobile_full.mk)

# Inherit tablet common stuff
$(call inherit-product, vendor/ryu/config/tablet.mk)

$(call inherit-product, vendor/ryu/config/wifionly.mk)
