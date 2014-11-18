#!/bin/bash
binary_directory = '/home/user/dir/'
binary_name = 'bin'
logfile = 'bin-log.txt'

cd $binary_directory
i=1
while [ $i -le 5000 ]
do
./$binary_name >> ./$logfile
i=`expr $i + 1`
done

