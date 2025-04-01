#!/bin/bash

set -e

main() {
    # disk_name is intentionally left empty to avoid accidentially shredding
    # a drive.
    local -r disk_name=''

    local -r output_file="output_shred_${disk_name}.txt"

    if [ -z "${disk_name}" ] ; then
        echo "Disk name is empty. Exiting."
        exit 1
    fi

    date &> ${output_file}
    udevadm info --query=all --name=/dev/${disk_name} | grep ID_SERIAL= &>> ${output_file}
    shred --verbose --zero /dev/${disk_name} &>> ${output_file}
    date &>> ${output_file}
}

main "${@}"
