# Apps
PRODUCT_PACKAGES += \
    EmergencyInfo

PRODUCT_PACKAGE_OVERLAYS += vendor/ryu/overlay/wifionly

TARGET_HAS_WIFIONLY := true
