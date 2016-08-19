#!/bin/bash -e

# An example script to run Postfix in production. It uses data volumes under the $DATA_ROOT directory.
# By default /srv.

NAME='postfix'

DATA_ROOT='/srv'
POSTFIX_DATA="${DATA_ROOT}/${NAME}/data"
POSTFIX_LOG="${DATA_ROOT}/${NAME}/log"

# The container network alias
NETWORK_ALIAS=smtp-server
# The container network to attach to
NETWORK_NAME=dev_nw
# The container network IP (to allow relaying from it)
NETWORK="172.25.0.0/16"

export MAILNAME='temporary.example.com'
export MY_NETWORKS="$NETWORK 127.0.0.0/8"
export ROOT_ALIAS='somebody@example.com'
export MY_DESTINATION='localhost.localdomain, localhost'
export MY_DOMAIN='example.com'

# The host and port to relay through
export RELAY_HOST='smtp.example.com:587'
export SMTP_USER='somebody'
export SMTP_PASSWORD='example_password'

mkdir -p "$POSTFIX_DATA"
mkdir -p "$POSTFIX_LOG"

docker stop "${NAME}" 2>/dev/null && sleep 1
docker rm "${NAME}" 2>/dev/null && sleep 1
docker run --detach=true --restart=always --name "${NAME}" --hostname "${MAILNAME}" \
    --env MAILNAME \
    --env MY_NETWORKS \
    --env ROOT_ALIAS \
    --env MY_DESTINATION \
    --env MY_DOMAIN \
    --env RELAY_HOST \
    --env SMTP_USER \
    --env SMTP_PASSWORD \
    --volume "${POSTFIX_LOG}:/var/log/postfix" \
    --volume "${POSTFIX_DATA}:/var/spool/postfix" \
    --network-alias ${NETWORK_ALIAS} \
    --network=${NETWORK_NAME} \
    redwyvern/postfix
