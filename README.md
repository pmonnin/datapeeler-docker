# datapeeler-docker

A dockerization of [DataPeeler](http://homepages.dcc.ufmg.br/~lcerf/fr/prototypes.html)

## Execution

To execute DataPeeler with Docker, use the provided ``datapeeler.sh`` script and send it the parameters to DataPeeler

More info about DataPeeler parameters are available in the [README of DataPeeler](http://homepages.dcc.ufmg.br/~lcerf/fr/prototypes.html)

## Available tests

Tests available under ``tests/`` are those provided by Loïc Cerf, downloadable with [DataPeeler](http://homepages.dcc.ufmg.br/~lcerf/fr/prototypes.html).

Tests can be executed with

```shell
make test
```

## Update info

The Dockerfile should *always* inherit from Ubuntu 14.04 otherwise problems at the compilation of DataPeeler arise.