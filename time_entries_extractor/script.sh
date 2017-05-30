#!/bin/bash

set -e

/opt/redmine_time_entries_extractor/redmine_time_entries_extractor_run.sh --context_param redmineUrl=$REDMINEURL --context_param apikey=$APIKEY --context_param outputDir=$OUTPUTDIR --context_param dbDatabase=$DBDATABASE --context_param dbHost=$DBHOST --context_param dbPort=$DBPORT --context_param dbUsername=$DBUSERNAME --context_param dbPassword=$DBPASSWORD --context_param dbSchema=$DBSCHEMA --context_param timeFrom=$TIMEFROM --context_param timeTo=$TIMETO --context_param forceDelete=$FORCEDELETE

export TESTKIBANAINDEX=$(curl --user $LOGSTASH_RW_USERNAME:$LOGSTASH_RW_PASSWORD -s 'http://elasticsearch:9200/_cat/indices?' | grep .kibana)
echo "testing in script.sh"
if [ ! -z "$TESTKIBANAINDEX" ]
then
  mkdir -p /$KIBANACONFIGURATIONDIR/INDEXNAME
  elasticdump --input=http://$LOGSTASH_RW_USERNAME:$LOGSTASH_RW_PASSWORD@elasticsearch:9200/.kibana --output=$ --type=mapping   > /$KIBANACONFIGURATIONDIR/INDEXNAME/kibana_mapping.json
  elasticdump --input=http://$LOGSTASH_RW_USERNAME:$LOGSTASH_RW_PASSWORD@elasticsearch:9200/.kibana --output=$ --type=analyzer  > /$KIBANACONFIGURATIONDIR/INDEXNAME/kibana_analyzer.json
  elasticdump --input=http://$LOGSTASH_RW_USERNAME:$LOGSTASH_RW_PASSWORD@elasticsearch:9200/.kibana --output=$ --type=data      > /$KIBANACONFIGURATIONDIR/INDEXNAME/kibana_data.json
fi
export TESTKIBANAINDEX=''


