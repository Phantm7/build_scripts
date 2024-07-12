#!/bin/bash

rm -rf .repo/local_manifests/

# repo init rom
repo init -u https://github.com/RisingTechOSS/android -b fourteen --git-lfs
echo "=================="
echo "Repo init success"
echo "=================="

# Local manifests
git clone https://github.com/PhantomEnigma/local_manifests -b a14-rising .repo/local_manifests
echo "============================"
echo "Local manifest clone success"
echo "============================"

cd .repo/repo
git pull -r
cd ../..

# Sync
/opt/crave/resync.sh
echo "============="
echo "Sync success"
echo "============="

# keys
#rm -rf vendor/lineage-priv
#mkdir vendor/lineage-priv
#cp -r build-keys/* vendor/lineage-priv
echo "============="
echo "Keys copied"
echo "============="

# Export
export BUILD_USERNAME=Phantom
export BUILD_HOSTNAME=crave
export TARGET_KERNEL_CLANG_VERSION=r416183b
echo "======= Export Done ======"

# Set up build environment
source build/envsetup.sh
echo "====== Envsetup Done ======="

# Lunch
riseup Mi439_4_19 userdebug
echo "============="

# Build rom
rise b
