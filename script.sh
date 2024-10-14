#!/bin/bash

# Remove existing local_manifests
echo "==============================="
echo "Delete Manifest and Device Tree"
echo "==============================="
sudo rm -rf .repo/local_manifests/
sudo rm -rf device/* vendor/*

#repo init rom
repo init -u https://github.com/LineageOS/android.git -b lineage-22.0 --git-lfs --depth=1
echo "=================="
echo "Repo init success"
echo "=================="

#Local manifests
git clone https://github.com/tecno-mt6768/local_manifest -b lineage-KH7n .repo/local_manifests
echo "============================"
echo "Local manifest clone success"
echo "============================"

/opt/crave/resync.sh || repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags
echo "============="
echo "Sync success"
echo "============="

# Export
export BUILD_USERNAME="isus203"
export BUILD_HOSTNAME="crave"
echo "======= Export Done ======"

# Set up build environment
source build/envsetup.sh
echo "====== Envsetup Done ======="

lunch lineage_KH7n-userdebug || lunch lineage_KH7n-ap1a-userdebug

make installclean -j$(nproc --all)
echo "============="

echo "Build system"
make bacon
