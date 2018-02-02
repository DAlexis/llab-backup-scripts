#!/bin/bash

set -e

disk_label=backup
user_owner=backuper

mhddfs_dir=/mnt/data
fstab_tmp=/tmp/fstab-tmp.txt

echo " = Mounting ${disk_label}X disks to /mnt/${disk_label}X and patching to fstab"

lsblk -f | grep $disk_label | awk '{ print "UUID="$4"\t/mnt/"$3"\t"$2"\tdefaults,noatime\t0\t2"}' > $fstab_tmp

mhddfs_line="mhddfs#"

while read line; do

	uuid=`echo $line | awk '{print $1}'`
	
	dir=`echo $line | awk '{print $2}'`
	mhddfs_line=$mhddfs_line",$dir"
	if grep -q $dir /etc/fstab; then
	    echo "Attention! Directory $dir already in fstab!"
	else
		umount $dir || /bin/true
		mkdir -p $dir		
		echo "Adding to fstab line:"		
		echo "$line" | tee -a /etc/fstab
		mount $dir
		chown $user_owner:$user_owner $dir
	fi
	
done <$fstab_tmp

echo " = Setting up mhddfs"
mhddfs_line=`echo $mhddfs_line | sed '0,/\,/s/\,//'`
mhddfs_line=$mhddfs_line" $mhddfs_dir fuse defaults,allow_other,mlimit=10G 0 0"

mkdir -p $mhddfs_dir
chown -R $user_owner:$user_owner $dir

if grep -q $mhddfs_dir /etc/fstab; then
	echo "Attention! mhddfs already added to fstab"
else
	echo "Adding to fstab:"
	echo "$mhddfs_line" | tee -a /etc/fstab
fi

sed -i s/#user_allow_other/user_allow_other/ /etc/fuse.conf

umount $mhddfs_dir || true
mount $mhddfs_dir
