#!/bin/bash

set -eu

PORT=8022
IMAGE_FILE=${PWD}/image/output-mlt/mlt

show_msg(){
    local msg="$1"
    local color_code="$2"

    echo -e "\033[0;${color_code}m${msg}\033[0m"
}

show_success(){
    show_msg "$1" "32"
}

show_failure(){
    show_msg "$1" "31"
}

execute_remote_command(){
    ssh -i image/keypair/private -p ${PORT} -q -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no mlt@localhost "$*"
}

wait_for_ssh(){
    echo "Waiting for machine up..."
    retry=30
    while ! execute_remote_command true; do
        retry=$(( retry - 1 ))
        if [ $retry -le 0 ]; then
            show_failure "Timed out waiting for ssh. Aborting!"
            exit 1
        fi
        sleep 10
    done
    show_success "Done"
}

compile_xen_disk(){
    (
        echo "Compiling xen-disk..."
        if execute_remote_command ". /home/mlt/.profile && cd /home/mlt/xen-disk && make"; then
            show_success "xen-disk compiled"
        else
            show_failure "xen-disk failed to compile"
            exit 1
        fi
    )
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
systemd-run --user \
            --unit mlt-vm \
            kvm -m 1024 \
            -nographic \
            -snapshot \
            -netdev user,id=mynet0,hostfwd=tcp::${PORT}-:22 -device pcnet,netdev=mynet0 \
            -netdev user,id=mynet1 -device pcnet,netdev=mynet1 \
            "$IMAGE_FILE"

# wait for ssh
wait_for_ssh

compile_xen_disk

# TODO: on instance: execute unikernel and save log
