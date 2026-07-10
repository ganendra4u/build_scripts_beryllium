#!/bin/bash

rm -rf .repo/local_manifests/

repo init -u https://github.com/DerpFest-AOSP/android_manifest.git -b 16.2 --git-lfs

git clone https://github.com/ganendra4u/local_manifest_beryllium.git .repo/local_manifests -b main

/opt/crave/resync.sh

export BUILD_USERNAME=ganx0000
export BUILD_HOSTNAME=crave
export BUILD_BROKEN_MISSING_REQUIRED_MODULES=true

source build/envsetup.sh

lunch lineage_beryllium-bp4a-user

mka derp

mkdir -p imgs_output
cp out/target/product/beryllium/boot.img imgs_output/
cp out/target/product/beryllium/dtbo.img imgs_output/
cp out/target/product/beryllium/recovery.img imgs_output/ 2>/dev/null || true
cp out/target/product/beryllium/*.zip imgs_output/
