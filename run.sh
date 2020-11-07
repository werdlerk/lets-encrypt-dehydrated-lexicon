#!/bin/bash
set -euo pipefail

export STAGE=${STAGE:-false}
export CHALLENGE_TYPE=${CHALLENGE_TYPE:-"dns-01"}
export CONTACT_EMAIL=${CONTACT_EMAIL:-""}

mkdir -p \
  /data \
  /data/certs \
  /data/accounts \
  /srv/dehydrated/config.d

touch /data/domains.txt /var/log/dehydrated

if [ "$STAGE" = true ]; then
  echo 'CA="https://acme-staging-v02.api.letsencrypt.org/directory"' > /srv/dehydrated/config.d/stage.sh
fi

echo "CONTACT_EMAIL=\"${CONTACT_EMAIL}\"" > /srv/dehydrated/config.d/email.sh
echo "CHALLENGETYPE=\"${CHALLENGE_TYPE}\"" > /srv/dehydrated/config.d/challenge.sh

echo "Registering account..."
/srv/dehydrated/dehydrated --config /srv/dehydrated/config --register --accept-terms

env > /etc/environment
rsyslogd
cron
tail -F /var/log/dehydrated
