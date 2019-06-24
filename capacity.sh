#!/bin/bash

RESERVED=${RESERVED:-false}
FACILITYS=${FACILITYS:-sjc1 ewr1 ams1 nrt1 dfw2}
PACKET_AUTH_TOKEN=${PACKET_AUTH_TOKEN:-"$TF_VAR_packet_api_key"}
MASTER_NODE_COUNT=${MASTER_NODE_COUNT:-"$TF_VAR_master_node_count"}
WORKER_NODE_COUNT=${WORKER_NODE_COUNT:-"$TF_VAR_worker_node_count"}
MASTER_PLAN=${MASTER_PLAN:-"$TF_VAR_packet_master_device_plan"}
WORKER_PLAN=${WORKER_PLAN:-"$TF_VAR_packet_worker_device_plan"}

#Start on-demand Capacity loop.
if [ "$RESERVED" = "false" ]; then
    while [ "$MASTER_CAPACITY" != "true" ] && [ "$WORKER_CAPACITY" != "true" ]; do
        for facility in $FACILITYS; do
            echo "Looking in facility: $facility"
            export FACILITY=$facility
            MASTER_CAPACITY=$(curl -sX POST --header "Content-Type: application/json" \
                                   --header "Accept: application/json" \
                                   --header "X-Auth-Token: ${PACKET_AUTH_TOKEN}" \
                                   --data "{\"servers\":[{\"facility\": \"${FACILITY}\",\"plan\": \"${MASTER_PLAN}\",\"quantity\": \"${MASTER_NODE_COUNT}\"}]}" https://api.packet.net/capacity | jq '.[]' | jq '.[]' | jq '.available')
            WORKER_CAPACITY=$(curl -sX POST --header "Content-Type: application/json" \
                                   --header "Accept: application/json" \
                                   --header "X-Auth-Token: ${PACKET_AUTH_TOKEN}" \
                                   --data "{\"servers\":[{\"facility\": \"${FACILITY}\",\"plan\": \"${WORKER_PLAN}\",\"quantity\": \"${WORKER_NODE_COUNT}\"}]}" https://api.packet.net/capacity | jq '.[]' | jq '.[]' | jq '.available')
            if [ "$MASTER_CAPACITY" = "true" ] && [ "$WORKER_CAPACITY" = "true" ]; then
                break
            fi
        done
    done
    echo "selected facility: $FACILITY"
else
    while [ "$CAPACITY" != "true" ]; do
        #Get href for all allowed facilitys, then loop on servers in the desired region.
        for facility in $FACILITYS; do
            echo "Looking in facility: $facility"
            FACILITY_HREF=$(curl -sX GET --header "Accept: application/json" \
                                 --header "X-Auth-Token: ${PACKET_AUTH_TOKEN}" \
                                 https://api.packet.net/projects/"${PACKET_PROJECT_ID}"/facilities | jq '.facilities[]' | jq "select (.code==\"${facility}\")" | jq -r '.id')

            MASTER_NODES=$(curl -sX GET --header "Content-Type: application/json" \
                                --header "X-Auth-Token: ${PACKET_AUTH_TOKEN}" \
                                https://api.packet.net/projects/"${PACKET_PROJECT_ID}"/hardware-reservations?per_page=1000 | jq '.hardware_reservations[] | select(.provisionable==true)' | jq "select (.facility.href==\"/facilities/${FACILITY_HREF}\")" | jq "select (.plan.name==\"${MASTER_PLAN}\")" | jq '.id')


            WORKER_NODES=$(curl -sX GET --header "Content-Type: application/json" \
                                --header "X-Auth-Token: ${PACKET_AUTH_TOKEN}" \
                                https://api.packet.net/projects/"${PACKET_PROJECT_ID}"/hardware-reservations?per_page=1000 | jq '.hardware_reservations[] | select(.provisionable==true)' | jq "select (.facility.href==\"/facilities/${FACILITY_HREF}\")" | jq "select (.plan.name==\"${WORKER_PLAN}\")" | jq '.id')
            #Create array of nodes
            MASTER_COUNT=( $MASTER_NODES )
            WORKER_COUNT=( $MASTER_NODES )
            echo "master count: ${#MASTER_COUNT[@]}"
            echo "worker count: ${#WORKER_COUNT[@]}"

            # Break if we have capacity, otherwise continue looping.
            if [ ${#MASTER_COUNT[@]} -ge $MASTER_NODE_COUNT ] && [ ${#WORKER_COUNT[@]} -ge $WORKER_NODE_COUNT ]; then
                export FACILITY="${facility}"
                export CAPACITY=true
                echo "selected facility: $FACILITY"
                break
            fi
        done
    done
fi
