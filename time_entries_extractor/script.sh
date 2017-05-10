#!/bin/bash

set -e

elasticdump --input=http://LOGSTASH_RW_USERNAME:LOGSTASH_RW_PASSWORD@elasticsearch:9200/.kibana --output=$ --type=mapping  > KIBANACONFIGURATIONDIR/configurationKibana/INDEXNAME/kibana_mapping.json 
elasticdump --input=http://LOGSTASH_RW_USERNAME:LOGSTASH_RW_PASSWORD@elasticsearch:9200/kibana --output=$ --type=analyzer  > KIBANACONFIGURATIONDIR/configurationKibana/INDEXNAME/kibana_analyzer.json
elasticdump --input=http://LOGSTASH_RW_USERNAME:LOGSTASH_RW_PASSWORD@elasticsearch:9200/.kibana --output=$ --type=data  > KIBANACONFIGURATIONDIR/configurationKibana/INDEXNAME/kibana_data.json

/opt/redmine_time_entries_extractor/redmine_time_entries_extractor_run.sh --context_param redmineUrl=REDMINEURL --context_param apikey=APIKEY --context_param timeFrom=TIMEFROM --context_param timeTo=TIMETO --context_param outputDir=OUTPUTDIR --context_param dbDatabase=DBDATABASE --context_param dbHost=DBHOST --context_param dbPort=DBPORT --context_param dbUsername=DBUSERNAME --context_param dbPassword=DBPASSWORD --context_param dbSchema=DBSCHEMA --context_param forceDelete=FORCEDELETE
