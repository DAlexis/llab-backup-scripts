#!/bin/bash

# set -e

user_host="backuper@diogen.lightninglab.ru"
keys="-HavzP"
log_file="errlog.txt"

echo --------------------------- >> $log_file
date >> $log_file
echo --------------------------- >> $log_file

rsync $keys --exclude 'lost+found' $user_host:/mnt/storage1/ /mnt/backup1/ 2>> $log_file
rsync $keys --exclude 'lost+found' $user_host:/mnt/storage2/ /mnt/backup2/ 2>> $log_file
rsync $keys --exclude 'lost+found' $user_host:/mnt/storage3/ /mnt/backup3/ 2>> $log_file
rsync $keys --exclude 'lost+found' $user_host:/mnt/storage4/ /mnt/backup4/ 2>> $log_file
rsync $keys --exclude 'lost+found' --exclude 'mysql' $user_host:/mnt/storage5/ /mnt/backup5/ 2>> $log_file
rsync $keys --exclude 'lost+found' $user_host:/mnt/storage6/ /mnt/backup6/ 2>> $log_file
