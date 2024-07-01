#!/bin/bash

rm -rf .repo/local_manifests/

# repo init rom
repo init --depth=1 -u https://github.com/ProjectBlaze/manifest -b 14-QPR3
echo "=================="
echo "Repo init success"
echo "=================="

# Local manifests
git clone https://github.com/PhantomEnigma/local_manifests -b a14-projectblaze .repo/local_manifests
echo "============================"
echo "Local manifest clone success"
echo "============================"

# build
/opt/crave/resync.sh
echo "============="
echo "Sync success"
echo "============="

# keys
git clone https://github.com/PhantomEnigma/build_keys.git -b blaze-keys vendor/extra
echo "============="
echo "Keys copied"
echo "============="

# Export
export BUILD_USERNAME=Phantom
export BUILD_HOSTNAME=crave
export BLAZE_MAINTAINER=Phantom
echo "======= Export Done ======"

# Set up build environment
source build/envsetup.sh
echo "====== Envsetup Done ======="

# Lunch
lunch blaze_Mi439_4_19-ap1a-userdebug || lunch blaze_Mi439_4_19-userdebug
echo "============="
# Make cleaninstall
make installclean
echo "============="

# Build rom
mka bacon
