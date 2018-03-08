#!/bin/bash

set -e

sed "s#OUTPUTDIR#$OUTPUTDIR#g" -i /time_entries.conf
sed "s#LOGSTASH_RW_USERNAME#$LOGSTASH_RW_USERNAME#g" -i /time_entries.conf
sed "s#LOGSTASH_RW_PASSWORD#$LOGSTASH_RW_PASSWORD#g" -i /time_entries.conf
sed "s#INDEXNAME#$INDEXNAME#g" -i /time_entries.conf

mkdir -p /usr/share/logstash/config
cp /time_entries.conf /usr/share/logstash/config/time_entries.conf

echo "waiting until elasticsearch is up"
until curl -k https://$RW_USERNAME:$RW_PASSWORD@elasticsearch:9200 &>/dev/null; do sleep 5; done
echo "elasticsearch is up"

#sed "s#INDEXNAME#$INDEXNAME#g" -i /opt/script.sh

if [ "$RESETATSTARTUP" = "YES" ] || [ ! -d "/eea.kibana.configs" ];
then
  git clone https://github.com/eea/eea.kibana.configs.git /eea.kibana.configs
  if [ -d "/eea.kibana.configs/$INDEXNAME" ];
    then
      echo "folder /eea.kibana.configs/$INDEXNAME found, importing the dashboard"
      sh /opt/ingestConfiguration.sh
  fi
else
  cd /eea.kibana.configs
  git pull
fi

sh /opt/ingestData.sh

exec "$@" 

