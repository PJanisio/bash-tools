#!/bin/bash
#https://github.com/PJanisio/bash-tools
#--------------------------------------
#usage ./search.sh [searching_phtase] [path_to_dir]

#example ./search.sh "shit" /var/www/shitty_dir/files/ >> log.log

cd /
grep -rl $1 $2*
