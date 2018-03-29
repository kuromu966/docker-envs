BASE_IMAGE		:= centos:7
DATA_CONTAINER		:= host_mounter
MOUNT_POINT		:= /usr/local/docker

GCC_CONTAINER		:= gcc_build
GCC_IMAGE		:= gcc_build_img
BOOST_VERSION		:= 1.66.0

PYTHON3_CONTAINER	:= python3_build
PYTHON3_IMAGE		:= python_devel_img
PYTHON3_VERSION		:= 3.6.3
JUPYTER_PATH		:= jupyter
JUPYTER_PORT		:= 8000

RUBY_CONTAINER		:= ruby_build
RUBY_IMAGE		:= ruby_devel_img
RUBY_VERSION		:= 2.4.2

PERL_CONTAINER		:= perl_build
PERL_IMAGE		:= perl_devel_img
PERL_VERSION		:= 5.26.1

GO_CONTAINER		:= go_build
GO_IMAGE		:= go_devel_img
GO_VERSION		:= 1.10.0
GO_PATH			:= $(MOUNT_POINT)/src/sample-go


###############################################################
# Common
###############################################################
.PHONY: all
all: help

.PHONY: clean
clean: ddown ## delete files
	-@rm .docker-compose.yml
	-@find . -name '*~' -print | xargs rm
	@make -C ./etc/docker-compose/images clean
	@make -C ./src/sample-cpp clean
	@make -C ./src/sample-python3 clean
	@make -C ./src/sample-ruby clean
	@make -C ./src/sample-perl clean
	@make -C ./src/sample-go clean

.PHONY: help
help:
	@grep -E '^(#+)|[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

###############################################################
# Docker
###############################################################
.PHONY: create_env_files
create_env_files: .docker-compose.yml etc/docker-compose/images/Makefile
	@make -C ./etc/docker-compose/images all \
		BOOST_VERSION=$(BOOST_VERSION) \
		PYTHON3_VERSION=$(PYTHON3_VERSION) \
		RUBY_VERSION=$(RUBY_VERSION) \
		PERL_VERSION=$(PERL_VERSION) \
		GO_VERSION=$(GO_VERSION) \
		GO_PATH=$(GO_PATH) \
		BASE_IMAGE=$(BASE_IMAGE)

.docker-compose.yml: Makefile etc/docker-compose/docker-compose.tpl
	@cat etc/docker-compose/docker-compose.tpl | \
		sed "s/%%DATA_CONTAINER%%/${DATA_CONTAINER}/g" | \
		sed "s/%%GCC_CONTAINER%%/${GCC_CONTAINER}/g" | \
		sed "s/%%GCC_IMAGE%%/${GCC_IMAGE}/g" | \
		sed "s/%%PYTHON3_CONTAINER%%/${PYTHON3_CONTAINER}/g" | \
		sed "s/%%PYTHON3_IMAGE%%/${PYTHON3_IMAGE}/g" | \
		sed "s/%%JUPYTER_PATH%%/${JUPYTER_PATH}/g" | \
		sed "s/%%JUPYTER_PORT%%/${JUPYTER_PORT}/g" | \
		sed "s/%%RUBY_CONTAINER%%/${RUBY_CONTAINER}/g" | \
		sed "s/%%RUBY_IMAGE%%/${RUBY_IMAGE}/g" | \
		sed "s/%%PERL_CONTAINER%%/${PERL_CONTAINER}/g" | \
		sed "s/%%PERL_IMAGE%%/${PERL_IMAGE}/g" | \
		sed "s/%%GO_CONTAINER%%/${GO_CONTAINER}/g" | \
		sed "s/%%GO_IMAGE%%/${GO_IMAGE}/g" | \
		sed "s/%%BASE_IMAGE%%/${BASE_IMAGE}/g" | \
		sed "s|%%MOUNT_POINT%%|${MOUNT_POINT}|g" \
		 > .docker-compose.yml

.PHONY: dup
dup: create_env_files
	@docker ps | grep $(DATA_CONTAINER) | awk '$$1 == "" {exit};' | \
		docker-compose -f .docker-compose.yml up -d data

.PHONY: ddown
ddown: create_env_files ## Docker down
	@docker-compose -f .docker-compose.yml down

.PHONY: dlogs
dlogs: create_env_files ## Docker logs
	@docker-compose -f .docker-compose.yml logs -f

###############################################################
# GCC
###############################################################

.PHONY: dup-gcc
dup-gcc: dup ## up gcc container
	@docker-compose -f .docker-compose.yml up -d gcc

.PHONY: login-gcc
login-gcc: create_env_files ## Login gcc container
	@docker exec -it $(GCC_CONTAINER) /usr/bin/scl enable devtoolset-7 bash

.PHONY: build-gcc
build-gcc: create_env_files ## make all for src/sample-gcc
	@docker-compose -f .docker-compose.yml run --rm gcc-build

.PHONY: _build-gcc
_build-gcc:
	@date
	@/usr/bin/scl enable devtoolset-7 "make -C ./src/sample-cpp all"
	@date

.PHONY: sample-gcc
sample-gcc: ## Run C++ Sample code
	@docker-compose -f .docker-compose.yml run --service-ports --rm gcc-run ./sample-cpp/bin/sample --op=add --lhs=1 --rhs=2

###############################################################
# Python3
###############################################################

.PHONY: dup-python3
dup-python3: dup ## up python3 container
	@docker-compose -f .docker-compose.yml up -d python3

.PHONY: login-python3
login-python3: create_env_files ## Login python3 contaner
	@docker exec -it $(PYTHON3_CONTAINER) /bin/bash

.PHONY: sample-python3
sample-python3: ## Run Python Sample code
	@docker-compose -f .docker-compose.yml run --service-ports --rm python3-run /bin/bash -c "~/.pyenv/shims/python ./sample-python3/sample.py"

.PHONY:jupyter
jupyter: ## Run Jupyter Notebook on python3 container
	@docker-compose -f .docker-compose.yml run --service-ports --rm python3-jupyter /bin/bash -c "~/.pyenv/shims/jupyter notebook --ip 0.0.0.0 --allow-root"

###############################################################
# Ruby
###############################################################

.PHONY: dup-ruby
dup-ruby: dup ## up ruby container
	@docker-compose -f .docker-compose.yml up -d ruby

.PHONY: login-ruby
login-ruby: create_env_files ## Login ruby container
	@docker exec -it $(RUBY_CONTAINER) /bin/bash

.PHONY: sample-ruby
sample-ruby: ## Run Ruby Sample code
	@docker-compose -f .docker-compose.yml run --service-ports --rm ruby-run /bin/bash -c "~/.rbenv/shims/ruby ./sample-ruby/sample.rb"


###############################################################
# Perl 5
###############################################################

.PHONY: dup-perl
dup-perl: dup ## up perl container
	@docker-compose -f .docker-compose.yml up -d perl

.PHONY: login-perl
login-perl: create_env_files ## Login perl container
	@docker exec -it $(PERL_CONTAINER) /bin/bash

.PHONY: sample-perl
sample-perl: ## Run Perl Sample code
	@docker-compose -f .docker-compose.yml run --service-ports --rm perl-run /bin/bash -c "~/.plenv/shims/perl ./sample-perl/sample.pl --sample 'hello world'"

###############################################################
# Go
###############################################################

.PHONY: dup-go
dup-go: dup ## up go container
	@docker-compose -f .docker-compose.yml up -d go

.PHONY: login-go
login-go: create_env_files ## Login go container
	@docker exec -it $(GO_CONTAINER) /bin/bash

.PHONY: deps-go
deps-go: create_env_files ## Download go dependencies
	@docker-compose -f .docker-compose.yml run --rm go-deps

.PHONY: _deps-go
_deps-go: create_env_files
	@make -C ./src/sample-go deps

.PHONY: build-go
build-go: create_env_files ## make all for src/sample-go
	@docker-compose -f .docker-compose.yml run --rm go-build

.PHONY: _build-go
_build-go:
	@date
	@make -C ./src/sample-go build
	@date

.PHONY: sample-go
sample-go: ## Run Go Sample code
	@docker-compose -f .docker-compose.yml run --service-ports --rm go-run ./sample-go/bin/hello


