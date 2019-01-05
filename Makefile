#
# Docker Makefile
#

# Variables
IMAGE=bdwyertech/journald-cloudwatch-logs
GIT_VERSION=master

#
.PHONY: help

help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help


build: ## Build the Container
	docker build . -t ${IMAGE}:centos7 -f el7.Dockerfile
	docker run --rm -iv${PWD}:/host ${IMAGE}:centos7 bash -c 'cp -f /usr/bin/journald-cloudwatch-logs /host/bin/el7'

publish: build ## Build & Publish the Container
	docker push ${IMAGE}:centos7
