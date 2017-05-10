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
sed "s#APIKEY#$APIKEY#g" -i /opt/script.sh

sed "s#DBUSERNAME#$DBUSERNAME#g" -i /opt/script.sh
sed "s#DBPASSWORD#$DBPASSWORD#g" -i /opt/script.sh

sed "s#FORCEDELETE#$FORCEDELETE#g" -i /opt/script.sh

sed "s#KIBANACONFIGURATIONDIR#$KIBANACONFIGURATIONDIR#g" -i /opt/script.sh
sed "s#INDEXNAME#$INDEXNAME#g" -i /opt/script.sh
sed "s#KIBANACONFIGURATIONDIR#$KIBANACONFIGURATIONDIR#g" -i /opt/ingestKibana.sh
sed "s#INDEXNAME#$INDEXNAME#g" -i /opt/ingestKibana.sh

sed "s#INDEXNAME#$INDEXNAME#g" -i /time_entries.conf

if [ "$RESETATSTARTUP" = "YES" ] && [ -d "$KIBANACONFIGURATIONDIR/configurationKibana" ];
then
    cd $KIBANACONFIGURATIONDIR/configurationKibana 
    git pull
#    rm -rf $KIBANACONFIGURATIONDIR
fi

if [ ! -d "$KIBANACONFIGURATIONDIR/configurationKibana" ]
then
  git clone https://github.com/eea/eea.kibana.configs.git $KIBANACONFIGURATIONDIR/configurationKibana
  cd $KIBANACONFIGURATIONDIR/configurationKibana/$INDEXNAME
#  git checkout $INDEXNAME
fi

#ls $KIBANACONFIGURATIONDIR/$INDEXNAME

if [ ! -z "$LOGSTASH_RW_USERNAME" ]; then
    sed "s#OUTPUTDIR#$OUTPUTDIR#g" -i /time_entries.conf
    sed "s#LOGSTASH_RW_USERNAME#$LOGSTASH_RW_USERNAME#g" -i /time_entries.conf
    sed "s#LOGSTASH_RW_PASSWORD#$LOGSTASH_RW_PASSWORD#g" -i /time_entries.conf
    mkdir -p /usr/share/logstash/config
    cp /time_entries.conf /usr/share/logstash/config/time_entries.conf

    sed "s#LOGSTASH_RW_USERNAME#$LOGSTASH_RW_USERNAME#g" -i /opt/script.sh
    sed "s#LOGSTASH_RW_PASSWORD#$LOGSTASH_RW_PASSWORD#g" -i /opt/script.sh

    sed "s#LOGSTASH_RW_USERNAME#$LOGSTASH_RW_USERNAME#g" -i /opt/ingestKibana.sh
    sed "s#LOGSTASH_RW_PASSWORD#$LOGSTASH_RW_PASSWORD#g" -i /opt/ingestKibana.sh
fi

sleep 5

sh /opt/ingestKibana.sh
sh /opt/script.sh

exec "$@" 

