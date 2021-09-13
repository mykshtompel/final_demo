TAG ?= 0.0.1
REGISTRY_ID ?= 480681066960
REPOSITORY_REGION ?= us-east-2
APP ?= web
ENV ?= dev
NAME_CONTAINER ?= nginx
REPO_NAME = $(REGISTRY_ID).dkr.ecr.$(REPOSITORY_REGION).amazonaws.com/$(APP)-$(ENV)-$(NAME_CONTAINER)

.PHONY: build
build:
	$(MAKE) docker-login
	docker build -t $(REPO_NAME):$(TAG) .
	docker push $(REPO_NAME):$(TAG)

.PHONY: docker-login
docker-login:
	aws ecr get-login-password --region $(REPOSITORY_REGION) | docker login --username AWS --password-stdin $(REGISTRY_ID).dkr.ecr.$(REPOSITORY_REGION).amazonaws.com
