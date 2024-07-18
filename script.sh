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

# Export
export BUILD_USERNAME=Phantom
export BUILD_HOSTNAME=crave

export MITHORIUM_QCOM_HALS_DEFAULT_VARIANT=LA.UM.9.6.4.r1-05500-89xx.QSSI13.0
echo "======= Export Done ======"

# Set up build environment
source build/envsetup.sh
echo "====== Envsetup Done ======="

# Lunch
riseup Mi439_4_19 userdebug
echo "============="

# Build rom
rise b
