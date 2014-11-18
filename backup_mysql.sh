#!/bin/bash
#https://github.com/PJanisio/bash-tools
#--------------------------------------
#create mysql dump of database and tars it.
#than it can be stored on cloud service like dropbox ;)

#Predefined variables - do not touch
date=$(date +"%d-%b-%Y")
 
#Database and user credentials
user='user'
password='password'
host='localhost'
db_name='database'
 
#Backup directory
backup_path='/home/user/backup/backup-sql/'
 
#Dump database into SQL file
mysqldump --user=$user --password=$password --host=$host $db_name > $backup_path/$db_name-$date.sql

cd $backup_path
tar czvf $db_name-$date.tar.gz $db_name-$date.sql
rm -rf $db_name-$date.sql

#Upload to dropbox
#uncomment following code to enable pasting it to dropbox
#dependecies: https://github.com/andreafabrizi/Dropbox-Uploader

dropbox_uploader_path = '/root/dropbox-up/'
echo 'It can take several minutes to upload. Please wait'
$dropbox_uploader_path/dropbox_uploader.sh upload $backup_path/$db_name-$date.tar.gz $db_name-$date.tar.gz



