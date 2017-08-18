#!/bin/bash

if [ $# -eq 0 ]
then
	echo  -e "=== Help from datapeeler-docker\n"
	echo "Usage: docker run --rm qlf-sesi-harbor.inria.fr/orpailleur/dpeeler:latest [--getscript|DataPeeler options]"
	echo -e "--getscript\t\treturn the script that can be used to call DataPeeler thanks to the Docker image"
	echo -e "DataPeeler options\tSee DataPeeler help below\n"
	echo -e "Example:\ncopy-paste this line to get the starting script, named datapeeler.sh"
	echo "docker run --rm qlf-sesi-harbor.inria.fr/orpailleur/dpeeler:latest --getscript > datapeeler.sh && chmod 755 datapeeler.sh"
	echo ""
	echo -e "=== Help from DataPeeler\n"
	d-peeler
	exit 0
elif [ $# -eq 1 ] && [ $1 = "--getscript" ]
then
	cat /datapeeler.sh
	exit 0
fi

d-peeler "$@"
