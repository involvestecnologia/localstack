export APP_NAME = localstack
export REGISTRY_NAME = registry.agilepromoter.com/$(APP_NAME)

export DOCKER_BUILDKIT = 1

.PHONY: build-user-info
build-user-info:
	docker build --tag=$(REGISTRY_NAME):user-info --target=user-info .

.PHONY: push-user-info
push-user-info:
	docker push $(REGISTRY_NAME):user-info