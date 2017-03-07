#!/bin/bash

set -e

/opt/redmine_time_entries_extractor/redmine_time_entries_extractor_run.sh --context_param redmineUrl=REDMINEURL --context_param userName=USERNAME --context_param password=PASSWORD --context_param timeFrom=TIMEFROM --context_param timeTo=TIMETO --context_param outputDir=OUTPUTDIR --context_param dbDatabase=DBDATABASE --context_param dbHost=DBHOST --context_param dbPort=DBPORT --context_param dbUsername=DBUSERNAME --context_param dbPassword=DBPASSWORD --context_param dbSchema=DBSCHEMA
