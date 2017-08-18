.DEFAULT_GOAL := help

.PHONY: build help

OS=$(shell uname -s)

# UID mapping between host and container only matters when running Docker on Linux
ifeq ($(OS),Linux)
MAPUSER=-u $(shell id -u):$(shell id -g)
else
MAPUSER=
endif 

# Shared paths between host and container must be windows path when running Docker under Cygwin
# winpty must be executed as a prefix for a docker run interactive session under Cygwin
ifeq ($(OS),CYGWIN_NT-10.0)
TESTDIR=$(shell cygpath -m ${PWD}/tests)
INTERACTIVE=winpty
else
TESTDIR=${PWD}/tests
INTERACTIVE=
endif 

INAME=dpeeler
TAG=latest

help: ## Display available commands in Makefile
	@grep -hE '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

build: ## Build the dpeeler docker image
	docker build -t $(INAME):$(TAG) -f Dockerfile .

test: ## Execute DataPeeler on the tests provided by the program
	docker run --rm $(MAPUSER) -v $(TESTDIR):/d-peeler-workdir $(INAME):$(TAG) example.data

push: ## Push the Docker image to the registry
	docker push $(INAME):$(TAG)

bash: ## Start interactive mode with the Docker container
	$(INTERACTIVE) docker run -it --rm -v $(TESTDIR):/tests --entrypoint=bash $(INAME):$(TAG)
