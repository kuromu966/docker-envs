DIST_DIR 	:= ./dist
DEBUG 		:= 0
WATCH 		:= 0
SSL 		:= 0


.PHONY: all
all: help

.PHONY: help
help:
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: clean
clean:
	@if [ -d $(DIST_DIR) ]; then rm -r $(DIST_DIR); fi
	@find . -type f -name '*~' -exec rm -v {} \;


####################################################################
# Environment
####################################################################
.PHONY: setup
setup: ## Install packages using package.json
ifeq ($(SSL),0)
	@npm config set strict-ssl false
	@NODE_TLS_REJECT_UNAUTHORIZED=0 npm install
else
	@npm install
endif

.PHONY: check-versions
check-versions: ## Check module versions
	@echo "If you want to update modules, please try 'make update-modules'"
	@npm config set strict-ssl false
	@npm outdated

.PHONY: update-modules
update-modules: ## Update local modules
	@npm config set strict-ssl false
	@npm update

.PHONY: update-modules-latest
update-modules-latest: ## Update local modules to latest version
	@npm config set strict-ssl false
	@npm-check-updates -u
	@make -C ./ update-modules

####################################################################
# Tools
####################################################################
.PHONY: story
story: ## Run storybook
	@npm run storybook

.PHONY: jest
jest: ## Run jest
	@npm run jest

####################################################################
# Build
####################################################################
.PHONY: build
build: ## create js
ifeq ($(DEBUG),1)
ifeq ($(WATCH),1)
	@npm run build:devel:watch
else
	@npm run build:devel
endif
else
ifeq ($(WATCH),1)
	@npm run build:watch
else
	@npm run build
endif
endif

.PHONY: dll
dll: ## create dll js
	@npm run build:dll


