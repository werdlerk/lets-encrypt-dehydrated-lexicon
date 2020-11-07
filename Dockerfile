FROM python:3

# Setup dependencies
RUN apt-get update \
    && apt-get -y install cron rsyslog git --no-install-recommends \
    && rm -rf /var/lib/apt/lists/* \
    && sed -i 's/session    required     pam_loginuid.so/#session    required     pam_loginuid.so/' /etc/pam.d/cron

# Disable imklog module of rsyslog
RUN sed -i '/imklog/s/^/#/' /etc/rsyslog.conf

RUN git clone --depth 1 https://github.com/dehydrated-io/dehydrated.git /srv/dehydrated \
    && pip install -U dns-lexicon[full]

# Copy over dehydrated and & cron files
COPY ./dehydrated/default/hook.sh /data/hook.sh
COPY ./dehydrated/config /srv/dehydrated/config
COPY crontab /etc/crontab
COPY run.sh /

RUN chmod +x /run.sh \
    && crontab /etc/crontab \
    && touch /var/log/cron

RUN chmod 600 /etc/crontab

CMD [ "/run.sh" ]
