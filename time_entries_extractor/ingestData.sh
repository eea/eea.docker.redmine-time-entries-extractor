#!/bin/bash

set -e

/opt/redmine_time_entries_extractor/redmine_time_entries_extractor_run.sh --context_param redmineUrl=$REDMINEURL --context_param apikey=$APIKEY --context_param outputDir=$OUTPUTDIR --context_param dbDatabase=$DBDATABASE --context_param dbHost=$DBHOST --context_param dbPort=$DBPORT --context_param dbUsername=$DBUSERNAME --context_param dbPassword=$DBPASSWORD --context_param dbSchema=$DBSCHEMA --context_param timeFrom=$TIMEFROM --context_param timeTo=$TIMETO --context_param forceDelete=$FORCEDELETE

export TESTKIBANAINDEX=$(curl -k --user $LOGSTASH_RW_USERNAME:$LOGSTASH_RW_PASSWORD -s 'https://elasticsearch:9200/_cat/indices?' | grep kibana)

echo pre import TESTKIBANAINDEX=$TESTKIBANAINDEX

if [ ! -z "$TESTKIBANAINDEX" ]
then
  rm -fr /$KIBANACONFIGURATIONDIR/$INDEXNAME
  mkdir -p /$KIBANACONFIGURATIONDIR/$INDEXNAME
  cd /$KIBANACONFIGURATIONDIR/$INDEXNAME 
  echo /$KIBANACONFIGURATIONDIR/$INDEXNAME

NODE_TLS_REJECT_UNAUTHORIZED=0 elasticdump --input-index=.kibana --headers='{"Content-Type": "application/json"}' --input="https://$LOGSTASH_RW_USERNAME:$LOGSTASH_RW_PASSWORD@elasticsearch:9200" --output=kibana_mapping.json --type=mapping
  NODE_TLS_REJECT_UNAUTHORIZED=0 elasticdump --input-index=.kibana --headers='{"Content-Type": "application/json"}' --input="https://$LOGSTASH_RW_USERNAME:$LOGSTASH_RW_PASSWORD@elasticsearch:9200" --output=kibana_analyzer.json --type=analyzer
  NODE_TLS_REJECT_UNAUTHORIZED=0 elasticdump --input-index=.kibana --headers='{"Content-Type": "application/json"}' --input="https://$LOGSTASH_RW_USERNAME:$LOGSTASH_RW_PASSWORD@elasticsearch:9200" --output=kibana_data.json --type=data

export TESTKIBANAINDEX=$(curl -k --user $LOGSTASH_RW_USERNAME:$LOGSTASH_RW_PASSWORD -s 'https://elasticsearch:9200/_cat/indices?' | grep kibana)
echo post import TESTKIBANAINDEX=$TESTKIBANAINDEX
fi

export TESTKIBANAINDEX=''