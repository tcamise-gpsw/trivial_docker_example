.PHONY: help
help: ## Display this help which is generated from Make goal comments
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: setup
setup: ## Build the docker image
	@docker compose build

.PHONY: clean-shared-volume
clean-shared-volume: ## Clean the shared volume
	@cd ./shared_volume && git clean -dfx .