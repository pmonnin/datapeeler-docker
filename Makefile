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

INAME=qlf-sesi-harbor.inria.fr/orpailleur/dpeeler
VERSION=latest

help: ## Display available commands in Makefile
	@grep -hE '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

build: ## Build the dpeeler docker image
	@docker build -t $(INAME):$(VERSION) build/
	@docker tag $(INAME):$(VERSION) dpeeler:$(VERSION)

test: ## Execute DataPeeler on the tests provided by the program
	@docker run --rm $(MAPUSER) -v $(TESTDIR):/d-peeler-workdir $(INAME):$(VERSION) example.data
	@diff $(TESTDIR)/example.data.out $(TESTDIR)/example.data.out.expected ; if [ $$? -eq 0 ] ; then echo "Tests OK!"; else echo "Tests failed"; fi

remove_dangling: ## Remove Docker dangling images
	@docker image prune -f

push: ## Push the Docker image to the registry
	@docker push $(INAME):$(VERSION)

bash: ## Start interactive mode with the Docker container
	@$(INTERACTIVE) docker run -it --rm -v $(TESTDIR):/tests --entrypoint=bash $(INAME):$(VERSION)

doc: ## Additional documentation for the image
	@docker run --rm dpeeler:latest
