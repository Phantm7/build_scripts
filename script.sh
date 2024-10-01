#!/bin/bash

rm -rf .repo/local_manifests/

repo init -u https://github.com/crdroidandroid/android.git -b 13.0 --git-lfs
echo "=================="
echo "Repo init success"
echo "=================="

# Local manifests
git clone https://github.com/PhantomEnigma/local_manifests -b a13-rev .repo/local_manifests
echo "============================"
echo "Local manifest clone success"
echo "============================"

# Sync
/opt/crave/resync.sh
echo "============="
echo "Sync success"
echo "============="


echo "===== Cherry-pick stuff started ====="

# 3 row a11 QS
cd vendor/addons
git fetch crdroid --unshallow
git fetch https://github.com/RisingTechOSS/android_vendor_addons fourteen
git cherry-pick dbd659e
cd ../..

#PIF
cd frameworks/base
git fetch crdroid --unshallow
git fetch https://github.com/PhantomEnigma/android_frameworks_base 13.0
git cherry-pick 69f4899
cd ../..

echo "===== Cherry-pick Ended ====="

# Export Example
#export BUILD_USERNAME=Phantom
#export BUILD_HOSTNAME=crave
#echo "======= Export Done ======"


# Set up build environment
source build/envsetup.sh
echo "====== Envsetup Done ======="

lunch lineage_Mi439_4_19-user
make installclean
mka bacon
