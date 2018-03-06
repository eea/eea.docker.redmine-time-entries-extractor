#!/bin/bash

set -e
NODE_TLS_REJECT_UNAUTHORIZED=0

elasticdump --headers='{"Content-Type": "application/json"}' --input=KIBANACONFIGURATIONDIR/configurationKibana/INDEXNAME/kibana_mapping.json --output=https://LOGSTASH_RW_USERNAME:LOGSTASH_RW_PASSWORD@elasticsearch:9200/.kibana
elasticdump --headers='{"Content-Type": "application/json"}' --input=KIBANACONFIGURATIONDIR/configurationKibana/INDEXNAME/kibana_analyzer.json --output=https://LOGSTASH_RW_USERNAME:LOGSTASH_RW_PASSWORD@elasticsearch:9200/kibana
elasticdump --headers='{"Content-Type": "application/json"}' --input=KIBANACONFIGURATIONDIR/configurationKibana/INDEXNAME/kibana_data.json --output=https://LOGSTASH_RW_USERNAME:LOGSTASH_RW_PASSWORD@elasticsearch:9200/.kibana

#elasticdump --input=KIBANACONFIGURATIONDIR/INDEXNAME/INDEXNAME_mapping.json --output=https://RW_USERNAME:RW_PASSWORD@elasticsearch:9200/INDEXNAME
#elasticdump --input=KIBANACONFIGURATIONDIR/INDEXNAME/INDEXNAME_analyzer.json --output=https://RW_USERNAME:RW_PASSWORD@elasticsearch:9200/INDEXNAME
#elasticdump --input=KIBANACONFIGURATIONDIR/INDEXNAME_data.json --output=https://RW_USERNAME:RW_PASSWORD@elasticsearch:9200/INDEXNAME
