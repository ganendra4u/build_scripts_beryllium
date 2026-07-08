#!/bin/bash

rm -rf .repo/local_manifests/

# repo init rom
repo init -u https://github.com/AxionAOSP/android.git -b lineage-23.2 --git-lfs --depth=1
echo "=================="
echo "Repo init success"
echo "=================="

# Local manifests
git clone https://github.com/ganendra4u/local_manifest_beryllium.git .repo/local_manifests -b main
echo "============================"
echo "Local manifest clone success"
echo "============================"


# Build Sync
/opt/crave/resync.sh
echo "============="
echo "Sync success"
echo "============="

# Export
export BUILD_USERNAME=ganx0000
export BUILD_HOSTNAME=crave
export AXION_MAINTAINER=ganx0000
export AXION_BUILD_TYPE=UNOFFICIAL
export BUILD_BROKEN_MISSING_REQUIRED_MODULES=true
echo "======= Export Done ======"

# Set up build environment
source build/envsetup.sh
echo "============="

# Lunch
axion beryllium userdebug gms

# Build
ax -br

# Copy imgs to a separate folder for easy download
mkdir -p imgs_output
cp out/target/product/beryllium/boot.img imgs_output/
cp out/target/product/beryllium/dtbo.img imgs_output/
cp out/target/product/beryllium/recovery.img imgs_output/ 2>/dev/null || true
cp out/target/product/beryllium/*.zip imgs_output/
