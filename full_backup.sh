#!/bin/sh
### System Setup ###
DIRS="/home"
BACKUP=/tmp/backup.$$
NOW=$(date +"%d-%m-%Y")
DAY=$(date +"%a")
### MySQL Setup ###
MUSER="root"
MPASS="pass"
MHOST="localhost"
MYSQL="$(which mysql)"
MYSQLDUMP="$(which mysqldump)"
GZIP="$(which gzip)"
### FTP server Setup ###
FTPD="/sciezka/zdalna"
FTPU="userftp"
FTPP="password"
FTPS="hostftp.pl"
NCFTP="$(which ncftpput)"
### Start Backup for file system ###
[ ! -d $BACKUP ] && mkdir -p $BACKUP || :
  FTPD=FTPD"/full"
  FILE="files-$NOW.zip"
  zip -r $BACKUP/$FILE $DIRS
### Start MySQL Backup ###
# Get all databases name
DBS="$($MYSQL -u $MUSER -h $MHOST -p$MPASS -Bse 'show databases')"
for db in $DBS
do
 FILE=$BACKUP/mysql-$db.$NOW-$(date +"%T").gz
 $MYSQLDUMP -u $MUSER -h $MHOST -p$MPASS $db | $GZIP -9 > $FILE
done
### Dump backup using FTP ###
#Start FTP backup using ncftp
ncftp -u"$FTPU" -p"$FTPP" $FTPS<<EOF
mkdir $FTPD
mkdir $FTPD/$NOW
cd $FTPD/$NOW
lcd $BACKUP
mput *
quit
EOF
### Find out if ftp backup failed or not ###
rm -rf $BACKUP