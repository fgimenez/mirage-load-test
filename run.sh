#!/bin/sh

set -eu

PORT=8022
IMAGE_FILE=${PWD}/image/output-mlt/mlt

execute_remote_command(){
    ssh -i image/keypair/private -p ${PORT} -q -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no mlt@localhost "$*"
}

wait_for_ssh(){
    echo "Waiting for machine up and reachable..."
    retry=30
    while ! execute_remote_command true; do
        retry=$(( retry - 1 ))
        if [ $retry -le 0 ]; then
            echo "Timed out waiting for ssh. Aborting!"
            exit 1
        fi
        sleep 10
    done
}

# check if image exists, create if not
if [ ! -f "$IMAGE_FILE" ]; then
    (
        cd ./image
        packer build ubuntu.json
    )
fi

# start instance
trap 'systemctl --user stop mlt-vm' EXIT
systemd-run --user --unit mlt-vm kvm -m 1024 -nographic -snapshot -netdev user,id=mynet0,hostfwd=tcp::${PORT}-:22 -netdev user,id=mynet1 -device pcnet,netdev=mynet0 -device pcnet,netdev=mynet1 "$IMAGE_FILE"

# wait for ssh
wait_for_ssh

# TODO: on instance: compile unikernel

# TODO: on instance: execute unikernel and save log
