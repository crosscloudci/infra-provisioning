#!/bin/bash

MASTERS=($(terraform output "node_group_one"))
WORKERS_TWO=($(terraform output "node_group_two"))
WORKERS_THREE=($(terraform output "node_group_three" || true))

echo "---" > nodes.env
echo "nodes:" >> nodes.env

for master in "${MASTERS[@]}"; do
    echo "  - addr: $master" >> nodes.env
    echo "    role: master" >> nodes.env
done

for worker in "${WORKERS_TWO[@]}"; do
    echo "  - addr: $worker" >> nodes.env
    echo "    role: worker" >> nodes.env
done

for worker in "${WORKERS_THREE[@]}"; do
    echo "  - addr: $worker" >> nodes.env
    echo "    role: worker" >> nodes.env
done
