#!/bin/bash

set -e

sed "s#OUTPUTDIR#$OUTPUTDIR#g" -i /time_entries.conf
sed "s#LOGSTASH_RW_USERNAME#$LOGSTASH_RW_USERNAME#g" -i /time_entries.conf
sed "s#LOGSTASH_RW_PASSWORD#$LOGSTASH_RW_PASSWORD#g" -i /time_entries.conf
mkdir -p /usr/share/logstash/config
cp /time_entries.conf /usr/share/logstash/config/time_entries.conf

counter=0
while [ ! "$(curl -k https://$LOGSTASH_RW_USERNAME:$LOGSTASH_RW_PASSWORD@elasticsearch:9200 2> /dev/null)" -a $counter -lt 100  ]; do
  sleep 1
  let counter=counter+1
  echo "waiting for Elasticsearch to be up ($counter/100)"
done

sed "s#INDEXNAME#$INDEXNAME#g" -i /opt/script.sh

sed "s#INDEXNAME#$INDEXNAME#g" -i /time_entries.conf

if [ "$RESETATSTARTUP" = "YES" ] || [ ! -d "/eea.kibana.configs" ];
then
  git clone https://github.com/eea/eea.kibana.configs.git /eea.kibana.configs
  if [ -d "/eea.kibana.configs/$INDEXNAME" ];
    then
      NODE_TLS_REJECT_UNAUTHORIZED=0 elasticdump --input=/eea.kibana.configs/$INDEXNAME/kibana_mapping.json --output=https://$LOGSTASH_RW_USERNAME:$LOGSTASH_RW_PASSWORD@elasticsearch:9200/.kibana
      NODE_TLS_REJECT_UNAUTHORIZED=0 elasticdump --input=/eea.kibana.configs/$INDEXNAME/kibana_analyzer.json --output=https://$LOGSTASH_RW_USERNAME:$LOGSTASH_RW_PASSWORD@elasticsearch:9200/.kibana
      NODE_TLS_REJECT_UNAUTHORIZED=0 elasticdump --input=/eea.kibana.configs/$INDEXNAME/kibana_data.json --output=https://$LOGSTASH_RW_USERNAME:$LOGSTASH_RW_PASSWORD@elasticsearch:9200/.kibana
  fi
else
  cd /eea.kibana.configs
  git pull
fi
#ls $KIBANACONFIGURATIONDIR/$INDEXNAME

sh /opt/script.sh

exec "$@" 

