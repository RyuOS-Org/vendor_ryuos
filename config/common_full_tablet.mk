# Inherit mobile full common Ryu stuff
$(call inherit-product, vendor/ryu/config/common_mobile_full.mk)

# Inherit tablet common Ryu stuff
$(call inherit-product, vendor/ryu/config/tablet.mk)

$(call inherit-product, vendor/ryu/config/telephony.mk)
