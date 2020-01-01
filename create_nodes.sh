#!/bin/bash

MASTERS=($(terraform output "node_group_one"))
WORKERS=($(terraform output "node_group_two"))

echo "---" > nodes.env
echo "nodes:" >> nodes.env

for master in "${MASTERS[@]}"; do
    echo "  - addr: $master" >> nodes.env
    echo "    role: master" >> nodes.env
done

for worker in "${WORKERS[@]}"; do
    echo "  - addr: $worker" >> nodes.env
    echo "    role: worker" >> nodes.env
done
