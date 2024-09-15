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

# OTA support
cd packages/apps/Updater
git fetch crdroid --unshallow
git fetch https://github.com/PhantomEnigma/android_packages_apps_Updater 13.0
git cherry-pick 946090a
cd ../../..

#App Downgrade
cd frameworks/base
git fetch crdroid --unshallow
git fetch https://github.com/RisingTechOSS/android_frameworks_base fourteen
git cherry-pick ba93896
cd ../..

#Bypass SAF
cd frameworks/base
git fetch crdroid --unshallow
git fetch https://github.com/PhantomEnigma/android_frameworks_base 13.0
git cherry-pick 7b68921
echo "Test started"
git cherry-pick 00b7ee6
cd ../..

echo "===== Cherry-pick Ended ====="
# Export
export BUILD_USERNAME=Phantom
export BUILD_HOSTNAME=crave
#export MITHORIUM_QCOM_HALS_DEFAULT_VARIANT=LA.UM.9.6.4.r1-05500-89xx.QSSI13.0
echo "======= Export Done ======"


# Set up build environment
source build/envsetup.sh
echo "====== Envsetup Done ======="

lunch lineage_Mi439_4_19-userdebug
make installclean
mka bacon
