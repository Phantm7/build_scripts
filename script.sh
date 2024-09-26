#!/bin/bash

rm -rf .repo/local_manifests/

repo init --depth=1 -u https://github.com/AfterlifeOS/android_manifest.git -b 14 --git-lfs
echo "=================="
echo "Repo init success"
echo "=================="

# Local manifests
git clone https://github.com/PhantomEnigma/local_manifests -b a14-afterlife .repo/local_manifests
echo "============================"
echo "Local manifest clone success"
echo "============================"

# Sync
/opt/crave/resync.sh
echo "============="
echo "Sync success"
echo "============="

# Export
#export BUILD_USERNAME=Phantom
#export BUILD_HOSTNAME=crave
echo "======= Export Done ======"

# Set up build environment
source build/envsetup.sh
echo "====== Envsetup Done ======="

goafterlife Mi439_4_19 || goafterlife Mi439_4_19-userdebug || launch afterlife-ap3a
