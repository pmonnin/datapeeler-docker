#!/bin/bash

if [ $# -eq 0 ]
then
	echo "=== Help from datapeeler-docker"
	echo "Usage: docker run --rm dpeeler:latest [--getscript|DataPeeler options]"
	echo -e "--getscript\t\treturn the script that can be used to call DataPeeler thanks to the Docker image"
	echo -e "DataPeeler options\tSee DataPeeler help below\n\n"
	echo "=== Help from DataPeeler"
	d-peeler
	exit 0
elif [ $# -eq 1 ] && [ $1 = "--getscript" ]
then
	cat /datapeeler.sh
	exit 0
fi

d-peeler "$@"
