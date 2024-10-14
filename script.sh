rm -rf .repo/local_manifests/

#repo init rom
repo init --depth=1 -u https://github.com/ProjectBlaze/manifest -b 14-QPR2

#Local manifests
git clone https://github.com/PhantomEnigma/local_manifests_clo -b udc-2-blaze .repo/local_manifests

#build
/opt/crave/resync.sh
. build/envsetup.sh
lunch blaze_mi439-userdebug || lunch blaze_mi439-ap1a-userdebug
make installclean
make bacon
