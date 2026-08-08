#
# Copyright (C) 2024 The Android Open Source Project
# Copyright (C) 2024 SebaUbuntu's TWRP device tree generator
# Copyright (C) 2025-2026 The OrangeFox Recovery Project
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/daria/hormoz

# Maintainer/Version
TW_DEVICE_VERSION := Daria_Bond_II | Mahdi_Asghari
MAINTAINER := Mahdi_Asghari

# For building with minimal manifest
ALLOW_MISSING_DEPENDENCIES := true
BUILD_BROKEN_DUP_RULES := true
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true
BUILD_BROKEN_PREBUILT_ELF_FILES := true
BUILD_BROKEN_MISSING_REQUIRED_MODULES := true
SOONG_ALLOW_MISSING_DEPENDENCIES := true

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := cortex-a55

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := generic
TARGET_2ND_CPU_VARIANT_RUNTIME := cortex-a55

# Arch Suffix
TARGET_IS_64_BIT := true
TARGET_BOARD_SUFFIX := _64
#TARGET_USES_64_BIT_BINDER := true

# Power
ENABLE_CPUSETS := true
ENABLE_SCHEDBOOST := true

# Board
TARGET_BOARD_INFO_FILE := $(DEVICE_PATH)/board-info.txt

# Assert
TARGET_OTA_ASSERT_DEVICE := hormoz

# Platform
# NOTE: PRODUCT_PLATFORM must be defined *before* it is expanded by TARGET_BOARD_PLATFORM,
#       otherwise (with ':=') TARGET_BOARD_PLATFORM ends up empty.
PRODUCT_PLATFORM := mt6897
TARGET_BOARD_PLATFORM := $(PRODUCT_PLATFORM)

# MTK Hardware
BOARD_HAS_MTK_HARDWARE := true
BOARD_USES_MTK_HARDWARE := true
MTK_HARDWARE := true

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := $(TARGET_OTA_ASSERT_DEVICE)
TARGET_NO_BOOTLOADER := true
TARGET_USES_UEFI := true

# Kernel
TARGET_NO_KERNEL := true
BOARD_KERNEL_SEPARATED_DTBO := true
BOARD_RAMDISK_USE_LZ4 := true
TARGET_KERNEL_ARCH := $(TARGET_ARCH)
TARGET_KERNEL_HEADER_ARCH := $(TARGET_ARCH)
BOARD_PAGE_SIZE := 4096
BOARD_BOOT_HEADER_VERSION := 4
BOARD_KERNEL_BASE := 0x3fff8000
BOARD_RAMDISK_OFFSET := 0x26f08000
BOARD_KERNEL_OFFSET := 0x00008000
BOARD_TAGS_OFFSET := 0x07c88000
BOARD_DTB_OFFSET := 0x07c88000
BOARD_HEADER_SIZE := 2128

# Prebuilt DTB
TARGET_PREBUILT_DTB := $(DEVICE_PATH)/prebuilt/dtb.img
# Must equal the exact byte size of $(TARGET_PREBUILT_DTB)
BOARD_DTB_SIZE := 406157

# Vendor CMD
BOARD_VENDOR_CMDLINE := "bootopt=64S3,32N2,64N2 log_buf_len=4m androidboot.selinux=permissive"

# Args
BOARD_MKBOOTIMG_ARGS += --dtb $(TARGET_PREBUILT_DTB)
BOARD_MKBOOTIMG_ARGS += --vendor_cmdline $(BOARD_VENDOR_CMDLINE)
BOARD_MKBOOTIMG_ARGS += --pagesize $(BOARD_PAGE_SIZE) --board ""
BOARD_MKBOOTIMG_ARGS += --kernel_offset $(BOARD_KERNEL_OFFSET)
BOARD_MKBOOTIMG_ARGS += --ramdisk_offset $(BOARD_RAMDISK_OFFSET)
BOARD_MKBOOTIMG_ARGS += --tags_offset $(BOARD_TAGS_OFFSET)
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)
BOARD_MKBOOTIMG_ARGS += --dtb_offset $(BOARD_DTB_OFFSET)
BOARD_MKBOOTIMG_ARGS += --base $(BOARD_KERNEL_BASE)

# Partitions
BOARD_FLASH_BLOCK_SIZE := 262144
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 67108864
BOARD_SUPER_PARTITION_SIZE := 9126805504

# Dynamic Partition
BOARD_SUPER_PARTITION_GROUPS := main
BOARD_MAIN_SIZE := 9122611200
BOARD_MAIN_PARTITION_LIST := system \
                             system_ext \
                             system_dlkm \
                             vendor \
                             product \
                             vendor_dlkm \
                             odm_dlkm

BOARD_PARTITION_LIST := $(call to-upper, $(BOARD_MAIN_PARTITION_LIST))
$(foreach p, $(BOARD_PARTITION_LIST), $(eval BOARD_$(p)IMAGE_FILE_SYSTEM_TYPE := erofs))
$(foreach p, $(BOARD_PARTITION_LIST), $(eval TARGET_COPY_OUT_$(p) := $(call to-lower, $(p))))

# File System
BOARD_HAS_LARGE_FILESYSTEM := true
BOARD_SYSTEMIMAGE_PARTITION_TYPE := ext4
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDOR_DLKMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_ODM_DLKMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_SYSTEM_DLKMIMAGE_FILE_SYSTEM_TYPE := ext4

# Workaround for error copying vendor files to recovery ramdisk
TARGET_COPY_OUT_VENDOR := vendor
TARGET_COPY_OUT_PRODUCT := product
TARGET_COPY_OUT_VENDOR_DLKM := vendor_dlkm
TARGET_COPY_OUT_ODM_DLKM := odm_dlkm
TARGET_COPY_OUT_SYSTEM_DLKM := system_dlkm

# Recovery
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true
BOARD_USES_VENDOR_DLKMIMAGE := true
BOARD_USES_ODM_DLKMIMAGE := true
TARGET_RECOVERY_PIXEL_FORMAT := BGRA_8888
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/recovery/root/system/etc/recovery.fstab
# Recovery lives inside vendor_boot on this device - there is no /recovery partition
TARGET_NO_RECOVERY := true

# System as root
BOARD_HAS_NO_SELECT_BUTTON := true
BOARD_SUPPRESS_SECURE_ERASE := true
#BOARD_BUILD_SYSTEM_ROOT_IMAGE := false

# Properties
TARGET_SYSTEM_PROP += $(DEVICE_PATH)/system.prop

# Android Verified Boot
BOARD_AVB_ENABLE := true

# Hack: prevent anti rollback
PLATFORM_VERSION := 99.87.36
PLATFORM_VERSION_LAST_STABLE := $(PLATFORM_VERSION)
PLATFORM_SECURITY_PATCH := 2099-12-31
BOOT_SECURITY_PATCH := $(PLATFORM_SECURITY_PATCH)
VENDOR_SECURITY_PATCH := $(PLATFORM_SECURITY_PATCH)

# Vendor_boot recovery ramdisk
BOARD_USES_RECOVERY_AS_BOOT :=
BOARD_USES_GENERIC_KERNEL_IMAGE := true
BOARD_MOVE_RECOVERY_RESOURCES_TO_VENDOR_BOOT := true
BOARD_INCLUDE_RECOVERY_RAMDISK_IN_VENDOR_BOOT := true
BOARD_EXCLUDE_KERNEL_FROM_RECOVERY_IMAGE :=
BOARD_MOVE_GSI_AVB_KEYS_TO_VENDOR_BOOT := true
TW_LOAD_VENDOR_BOOT_MODULES := true

# Kernel modules - explicitly include all .ko files in vendor_boot ramdisk
BOARD_VENDOR_RAMDISK_KERNEL_MODULES := $(wildcard $(DEVICE_PATH)/recovery/root/lib/modules/*.ko)
BOARD_VENDOR_RAMDISK_KERNEL_MODULES_LOAD := $(strip $(shell cat $(DEVICE_PATH)/recovery/root/lib/modules/modules.load))

# Init
TARGET_INIT_VENDOR_LIB := libinit_hormoz
TARGET_RECOVERY_DEVICE_MODULES += libinit_hormoz

# TWRP / OrangeFox Configuration
TW_THEME := portrait_hdpi
TWRP_NEW_THEME := true
TW_FRAMERATE := 60
# Panel is 120 Hz - raise this once rendering is confirmed stable:
# TW_FRAMERATE := 120
TW_STATUS_ICONS_ALIGN := center
TW_EXTRA_LANGUAGES := true
TW_DEFAULT_LANGUAGE := en
TW_HAS_NO_DISPLAY_CUTOUT := false
TW_INPUT_BLACKLIST := "hbtp_vm"
TW_USE_TOOLBOX := true
TARGET_USES_MKE2FS := true
TW_NO_LEGACY_PROPS := true
TW_NO_BIND_SYSTEM := true
TW_PREPARE_DATA_MEDIA_EARLY := true
TW_USE_NEW_MINADBD := true
RECOVERY_SDCARD_ON_DATA := true
TW_BACKUP_EXCLUSIONS := /data/fonts
TW_USE_SERIALNO_PROPERTY_FOR_DEVICE_ID := true
TARGET_USE_CUSTOM_LUN_FILE_PATH := /config/usb_gadget/g1/functions/mass_storage.usb0/lun.%d/file
#TW_EXCLUDE_DEFAULT_USB_INIT := true

# Resolution
TARGET_SCREEN_WIDTH := 1220
TARGET_SCREEN_HEIGHT := 2712

# Set brightness path and level
TW_BRIGHTNESS_PATH := "/sys/class/leds/lcd-backlight/brightness"
TW_DEFAULT_BRIGHTNESS := 400
TW_MAX_BRIGHTNESS := 2047

# Include some binaries
TW_INCLUDE_LIBRESETPROP := true
TW_INCLUDE_REPACKTOOLS := true
TW_INCLUDE_RESETPROP := true
TW_INCLUDE_LPDUMP := true
TW_INCLUDE_LPTOOLS := true
TW_INCLUDE_FASTBOOTD := true

# Filesystem Feature
TW_INCLUDE_NTFS_3G := true
TW_INCLUDE_FUSE_NTFS := true
TW_INCLUDE_FUSE_EXFAT := true

# Excludes
TW_NO_HAPTICS := true
TW_EXCLUDE_APEX := true
#TW_EXCLUDE_PYTHON := true
#TW_EXCLUDE_NANO := true
#TW_EXCLUDE_TWRPAPP := true
#TW_EXCLUDE_TZDATA := true
#TW_EXCLUDE_BASH := true
#TW_EXCLUDE_LPTOOLS := true
#TW_EXCLUDE_LPDUMP := true

# Debug-tools
TWRP_INCLUDE_LOGCAT := true
TARGET_USES_LOGD := true
OF_DONT_KEEP_LOG_HISTORY := 1
OF_LOOP_DEVICE_ERRORS_TO_LOG := 1


# Crypto - kept DISABLED (flash-only recovery, no /data decrypt) as in the
# previous Daria tree. To attempt FBE decryption, flip these on:
TW_INCLUDE_CRYPTO := false
TW_INCLUDE_CRYPTO_FBE := false
#BOARD_USES_METADATA_PARTITION := true
#TW_INCLUDE_FBE_METADATA_DECRYPT := true
#TW_USE_FSCRYPT_POLICY := 2
#TW_FORCE_KEYMASTER_VER := 4
#OF_DEFAULT_KEYMASTER_VERSION := 4.0

# Vendor modules
# NOTE: this device ships aw_haptic.ko - there is no "haptic.ko" in
#       recovery/root/lib/modules, the old entry silently did nothing.
TW_LOAD_VENDOR_MODULES := "aw_haptic.ko mtu3.ko xhci-mtk-hcd-v2.ko extcon-mtk-usb.ko usb_boost.ko usb_meta.ko usb_dp_selector.ko phy-mtk-xsphy.ko"

# Haptics
# NOTE: no vibrator HAL binary is shipped in this tree yet, so AIDL haptics
#       are disabled. Enable once a working vendor vibrator service is added.
#TW_SUPPORT_INPUT_AIDL_HAPTICS := true
#TW_SUPPORT_INPUT_AIDL_HAPTICS_FQNAME := "IVibrator/default"
#TW_SUPPORT_INPUT_AIDL_HAPTICS_FIX_OFF := true

# Indicator
TW_CUSTOM_CPU_TEMP_PATH := "/sys/class/thermal/thermal_zone53/temp"
TW_BATTERY_SYSFS_WAIT_SECONDS := 6

USE_AB := true
