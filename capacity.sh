#!/bin/bash

MASTER_NODE_COUNT=${MASTER_NODE_COUNT:-1}
WORKER_NODE_COUNT=${WORKER_NODE_COUNT:-1}
FACILITYS=${FACILITYS:-sjc1 erw1 ams1 nrt1 dfw2}
PLAN=${PLAN:-c1.small.x86}

#Start Capacity loop.
while [ "$MASTER_CAPACITY" != "true" ] || [ "$WORKER_CAPACITY" != "true" ]; do
    for facility in $FACILITYS; do
        export FACILITY=$facility
        echo $FACILITY
        MASTER_CAPACITY=$(curl -sX POST --header "Content-Type: application/json" \
                               --header "Accept: application/json" \
                               --header "X-Auth-Token: ${PACKET_AUTH_TOKEN}" \
                               --data "{\"servers\":[{\"facility\": \"${FACILITY}\",\"plan\": \"${PLAN}\",\"quantity\": \"${MASTER_NODE_COUNT}\"}]}" https://api.packet.net/capacity | jq '.[]' | jq '.[]' | jq '.available')
        WORKER_CAPACITY=$(curl -sX POST --header "Content-Type: application/json" \
                               --header "Accept: application/json" \
                               --header "X-Auth-Token: ${PACKET_AUTH_TOKEN}" \
                               --data "{\"servers\":[{\"facility\": \"${FACILITY}\",\"plan\": \"${PLAN}\",\"quantity\": \"${WORKER_NODE_COUNT}\"}]}" https://api.packet.net/capacity | jq '.[]' | jq '.[]' | jq '.available')
        if [ "$MASTER_CAPACITY" = "true" ] && [ "$WORKER_CAPACITY" = "true" ]; then
           break
        fi
  done
done
echo "facility: $FACILITY"
