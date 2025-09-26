LOCAL_PATH := $(call my-dir)

PRODUCT_OUT := out/target/product/$(TARGET_DEVICE)

KERNEL := $(LOCAL_PATH)/prebuilt/Image
DTB := $(LOCAL_PATH)/prebuilt/mt6855.dtb

VENDOR_RAMDISK := $(LOCAL_PATH)/vendor_ramdisk/ramdisk.cpio
BOOT_RAMDISK := $(LOCAL_PATH)/boot_ramdisk/ramdisk.cpio
RECOVERY_RAMDISK := $(LOCAL_PATH)/recovery_ramdisk/ramdisk.cpio

INSTALLED_BOOTIMAGE := $(PRODUCT_OUT)/boot.img
INSTALLED_VENDORBOOTIMAGE := $(PRODUCT_OUT)/vendor_boot.img
INSTALLED_RECOVERYIMAGE := $(PRODUCT_OUT)/recovery.img

BOARD_KERNEL_CMDLINE := "console=ttyS0,115200n8 androidboot.hardware=mt6855"
BOARD_BOOT_HEADER_VERSION := 3
BOARD_KERNEL_PAGESIZE := 2048
BOARD_KERNEL_BASE := 0x40000000
PLATFORM_VERSION := 13.0.0
PLATFORM_SECURITY_PATCH := 2025-09-01

.PHONY: bootimage vendorbootimage recoveryimage

gzip_ramdisk = gzip -c $< > $@

$(INSTALLED_BOOTIMAGE): $(KERNEL) $(BOOT_RAMDISK).gz
	$(MKBOOTIMG) \
		--kernel $(KERNEL) \
		--ramdisk $(BOOT_RAMDISK).gz \
		--cmdline $(BOARD_KERNEL_CMDLINE) \
		--header_version $(BOARD_BOOT_HEADER_VERSION) \
		--pagesize $(BOARD_KERNEL_PAGESIZE) \
		--base $(BOARD_KERNEL_BASE) \
		--os_version $(PLATFORM_VERSION) \
		--os_patch_level $(PLATFORM_SECURITY_PATCH) \
		--output $@

$(BOOT_RAMDISK).gz: $(BOOT_RAMDISK)
	$(call gzip_ramdisk)

bootimage: $(INSTALLED_BOOTIMAGE)

$(INSTALLED_VENDORBOOTIMAGE): $(KERNEL) $(VENDOR_RAMDISK).gz $(DTB)
	$(MKBOOTIMG) \
		--kernel $(KERNEL) \
		--vendor_ramdisk $(VENDOR_RAMDISK).gz \
		--dtb $(DTB) \
		--cmdline $(BOARD_KERNEL_CMDLINE) \
		--header_version $(BOARD_BOOT_HEADER_VERSION) \
		--pagesize $(BOARD_KERNEL_PAGESIZE) \
		--base $(BOARD_KERNEL_BASE) \
		--os_version $(PLATFORM_VERSION) \
		--os_patch_level $(PLATFORM_SECURITY_PATCH) \
		--output $@

$(VENDOR_RAMDISK).gz: $(VENDOR_RAMDISK)
	$(call gzip_ramdisk)

vendorbootimage: $(INSTALLED_VENDORBOOTIMAGE)

$(INSTALLED_RECOVERYIMAGE): $(KERNEL) $(RECOVERY_RAMDISK).gz
	$(MKBOOTIMG) \
		--kernel $(KERNEL) \
		--ramdisk $(RECOVERY_RAMDISK).gz \
		--cmdline $(BOARD_KERNEL_CMDLINE) \
		--header_version $(BOARD_BOOT_HEADER_VERSION) \
		--pagesize $(BOARD_KERNEL_PAGESIZE) \
		--base $(BOARD_KERNEL_BASE) \
		--os_version $(PLATFORM_VERSION) \
		--os_patch_level $(PLATFORM_SECURITY_PATCH) \
		--output $@

$(RECOVERY_RAMDISK).gz: $(RECOVERY_RAMDISK)
	$(call gzip_ramdisk)

recoveryimage: $(INSTALLED_RECOVERYIMAGE)
