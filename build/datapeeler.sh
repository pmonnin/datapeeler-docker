#!/bin/bash

INAME="qlf-sesi-harbor.inria.fr/orpailleur/dpeeler"
VERSION="latest"
OS=$(uname -s)

# UID mapping between host and container only matters when running Docker on Linux
if [ $OS = "Linux" ]
then
MAPUSER="-u $(id -u):$(id -g)"
else
MAPUSER=
fi 

docker run --rm $MAPUSER -v $(pwd):/d-peeler-workdir $INAME:$VERSION "$@"
