rm -rf .repo/local_manifests/
#repo init rom
repo init -u https://github.com/Evolution-XYZ/manifest -b udc --git-lfs
#Local manifests
git clone https://github.com/PhantomEnigma/local_manifests -b a14-evo .repo/local_manifests
#build
/opt/crave/resync.sh
. build/envsetup.sh
lunch lineage_Mi439_4_19-ap1a-userdebug || lunch lineage_Mi439_4_19-userdebug
make installclean
m evolution
