# llab-backup-scripts
Some scripts for data storage ifrastructure of Lightning Laboratory

# mount-disks.sh
This script looks for hard disks named `backupXXX`, mounts it into `/mnt/backupXXX` directory, creates `/mnt/data` folder with `mhddfs`.

It modify `/etc/fstab`, `/etc/fuse.conf`. After running script, automounting on reboot is enabled.
