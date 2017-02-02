FROM alpine

RUN apk add --update git unzip openntpd openjdk8-jre bash

RUN git clone https://github.com/eea/redmine-time-entries-extractor.git

RUN unzip redmine-time-entries-extractor/redmine_time_entries_extractor_0.1.zip -d /opt
RUN chmod a+x /opt/redmine_time_entries_extractor/redmine_time_entries_extractor_run.sh

COPY script.sh /opt
RUN chmod a+x /opt/script.sh 

RUN mkdir -p /var/spool/cron/crontabs
COPY time_entries.conf /

COPY docker-entrypoint.sh /
RUN chmod a+x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ntpd -p pool.ntp.org && echo "$CRON_ENTRY" /opt/script.sh | crontab - && crond -f
