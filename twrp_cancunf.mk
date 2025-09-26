# Copyright (C) 2025 The Android Open Source Project
# Copyright (C) 2025 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from base product configs (mais específicos primeiro)
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Configurações comuns do TWRP
$(call inherit-product, vendor/twrp/config/common.mk)

# Inherit do device cancunf
$(call inherit-product, device/motorola/cancunf/device.mk)

PRODUCT_DEVICE := cancunf
PRODUCT_NAME := twrp_cancunf
PRODUCT_BRAND := motorola
PRODUCT_MODEL := moto g54 5G
PRODUCT_MANUFACTURER := motorola

PRODUCT_GMS_CLIENTID_BASE := android-motorola

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="cancunf_g_vext-user 12 T3TD33.16-66-3 2706d2 release-keys" \
    PRIVATE_BUILD_FINGERPRINT="motorola/cancunf_g_vext/cancunf:12/T3TD33.16-66-3/2706d2:user/release-keys"
