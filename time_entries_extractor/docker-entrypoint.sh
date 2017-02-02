#!/bin/bash

set -e

sed "s#REDMINEURL#$REDMINEURL#g" -i /opt/script.sh
sed "s#TIMEFROM#$TIMEFROM#g" -i /opt/script.sh
sed "s#TIMETO#$TIMETO#g" -i /opt/script.sh
sed "s#USERNAME#$USERNAME#g" -i /opt/script.sh
sed "s#PASSWORD#$PASSWORD#g" -i /opt/script.sh
sed "s#OUTPUTDIR#$OUTPUTDIR#g" -i /opt/script.sh

sed "s#OUTPUTDIR#$OUTPUTDIR#g" -i time_entries.conf

cp /time_entries.conf /etc/logstash/conf.d

exec "$@" 

