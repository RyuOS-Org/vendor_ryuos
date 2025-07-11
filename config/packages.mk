# RyuOS packages
PRODUCT_PACKAGES += \
    ThemePicker \
    AvatarPicker \
    ThemesStub \

# Extra tools in RyuOS
PRODUCT_PACKAGES += \
    awk \
    bzip2 \
    curl \
    getcap \
    libsepol \
    setcap \

# Filesystems tools
PRODUCT_PACKAGES += \
    fsck.exfat \
    mke2fs \
    mkfs.exfat

# RyuOS UDFPS animations
ifeq ($(EXTRA_UDFPS_ANIMATIONS),true)
PRODUCT_PACKAGES += \
    UdfpsIcons \
    UdfpsAnimations
endif
