#!/bin/bash

rm -rf .repo
sudo apt install bc bison build-essential ccache curl flex g++-multilib gcc-multilib git git-lfs gnupg gperf imagemagick lib32ncurses5-dev lib32readline-dev lib32z1-dev liblz4-tool libncurses5 libncurses5-dev libsdl1.2-dev libssl-dev libwxgtk3.0-gtk3-dev libxml2 libxml2-utils lzop pngcrush rsync schedtool squashfs-tools xsltproc zip zlib1g-dev
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
repo sync -c --no-clone-bundle --optimized-fetch --prune --force-sync -j$(nproc --all)
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
git cherry-pick e08cba2
cd ../..

echo "===== Cherry-pick Ended ====="

# Export Example
#export BUILD_USERNAME=Phantom
#export BUILD_HOSTNAME=crave
#echo "======= Export Done ======"


# Set up build environment
source build/envsetup.sh
echo "====== Envsetup Done ======="

lunch lineage_Mi439_4_19-userdebug
make installclean
mka bacon
