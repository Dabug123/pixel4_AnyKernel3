# AnyKernel3 Ramdisk Mod Script
# osm0sis @ xda-developers
# Changes for pixel4xl by Dabug123 @ xda-developers

## AnyKernel setup
# begin properties
properties() { '
kernel.string=Dabug123 Pixel4
do.devicecheck=0
do.modules=0
do.cleanup=1
do.cleanuponabort=0
device.name1=coral
device.name2=flame
supported.versions=
'; } # end properties

# shell variables
block=/dev/block/bootdevice/by-name/boot;
is_slot_device=1;
ramdisk_compression=auto;

## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. tools/ak3-core.sh;

## Trim partitions
fstrim -v /cache;
fstrim -v /data;

## AnyKernel file attributes
# set permissions/ownership for included ramdisk files
chmod -R 750 $ramdisk/*;
chown -R root:root $ramdisk/*;

## AnyKernel install
dump_boot;

# begin ramdisk changes

if [ -d $ramdisk/.backup ]; then
  patch_cmdline "skip_override" "skip_override";
else
  patch_cmdline "skip_override" "";
fi;

# end ramdisk changes

write_boot;
## end install

