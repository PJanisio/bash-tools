#!/bin/bash
#https://github.com/PJanisio/bash-tools
#--------------------------------------
#backup and tars whole directory

dir_to_backup = '/var/www/user/public_html'
backup_store_dir = '/home/backups/user/public_html'
date_stamp = `date +%d-%m-%y`


cd ./$dir_to_backup/
mkdir ~/$backup_store_dir/$date_stamp
cp -rvf * ~/$backup_store_dir/$date_stamp
cd $backup_store_dir/$date_stamp
tar czvf $date_stamp.tar.gz $date_stamp
rm -rf $backup_store_dir/$date_stamp
