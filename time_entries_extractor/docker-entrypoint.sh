#!/bin/bash

set -e

sed "s#REDMINEURL#$REDMINEURL#g" -i /opt/script.sh
sed "s#TIMEFROM#$TIMEFROM#g" -i /opt/script.sh
sed "s#TIMETO#$TIMETO#g" -i /opt/script.sh
sed "s#USERNAME#$USERNAME#g" -i /opt/script.sh
sed "s#PASSWORD#$PASSWORD#g" -i /opt/script.sh
sed "s#OUTPUTDIR#$OUTPUTDIR#g" -i /opt/script.sh

sed "s#OUTPUTDIR#$OUTPUTDIR#g" -i /etc/logstash/conf.d/time_entries.conf

if [ "$LOGSTASH_RW_USERNAME" ]; then
    sed "s#LOGSTASH_RW_USERNAME#$LOGSTASH_RW_USERNAME#g" -i time_entries.conf
    sed "s#LOGSTASH_RW_PASSWORD#$LOGSTASH_RW_PASSWORD#g" -i time_entries.conf
    cp /time_entries.conf /etc/logstash/conf.d
fi

exec "$@" 

