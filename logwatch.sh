#
#!/bin/bash
#

HOST=`hostname -s`
TS=`date +%y-%m-%d_%H:%M`

LOGDIR="/var/log/LOGWATCH"

## Cleanup logfiles after these number of days
LOCAL_RETENTION=14

## Create logfile
logwatch --detail high --range yesterday --format html >> /var/log/LOGWATCH/logwatch-$HOST-$TS.html

## send email report
echo "LOGWATCHFILE" | mail -s "LOGWATCH-$HOST-$TS" -A /var/log/LOGWATCH/logwatch-$HOST-$TS.html admins@mail.de


## delete obsolete files
echo "`date` - Delete logfiles"
find $LOGDIR/* -mtime +$LOCAL_RETENTION -exec rm {} \;
