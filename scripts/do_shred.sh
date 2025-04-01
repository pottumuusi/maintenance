#!/bin/bash

set -e

main() {
	local -r disk_name='sda'
	local -r output_file="output_shred_${disk_name}.txt"

	date &> ${output_file}
	udevadm info --query=all --name=/dev/${disk_name} | grep ID_SERIAL= &>> ${output_file}
	shred --verbose --zero /dev/${disk_name} &>> ${output_file}
	date &>> ${output_file}
}

main "${@}"
