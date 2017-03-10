#!/bin/bash

set -e

sed "s#REDMINEURL#$REDMINEURL#g" -i /opt/script.sh
sed "s#TIMEFROM#$TIMEFROM#g" -i /opt/script.sh
sed "s#TIMETO#$TIMETO#g" -i /opt/script.sh
sed "s#REDMINEUSERNAME#$REDMINEUSERNAME#g" -i /opt/script.sh
sed "s#REDMINEPASSWORD#$REDMINEPASSWORD#g" -i /opt/script.sh
sed "s#OUTPUTDIR#$OUTPUTDIR#g" -i /opt/script.sh

sed "s#DBHOST#$DBHOST#g" -i /opt/script.sh
sed "s#DBDATABASE#$DBDATABASE#g" -i /opt/script.sh
sed "s#DBSCHEMA#$DBSCHEMA#g" -i /opt/script.sh
sed "s#DBPORT#$DBPORT#g" -i /opt/script.sh
sed "s#DBUSERNAME#$DBUSERNAME#g" -i /opt/script.sh
sed "s#DBPASSWORD#$DBPASSWORD#g" -i /opt/script.sh

sed "s#FORCEDELETE#$FORCEDELETE#g" -i /opt/script.sh

if [ "$LOGSTASH_RW_USERNAME" ]; then
    sed "s#OUTPUTDIR#$OUTPUTDIR#g" -i time_entries.conf
    sed "s#LOGSTASH_RW_USERNAME#$LOGSTASH_RW_USERNAME#g" -i time_entries.conf
    sed "s#LOGSTASH_RW_PASSWORD#$LOGSTASH_RW_PASSWORD#g" -i time_entries.conf
    mv time_entries.conf /usr/share/logstash/config/time_entries.conf
fi

exec "$@" 

