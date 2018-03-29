NAME            := hello
DOCS            := README.md
SRCS            := $(shell git ls-files '*.go' | grep -v '.pb.go')
PKGS            := *.go
BUILD_PATH	:= ./src/github.com/sample/main.go

VERSION    	:= $(shell git describe --tags --abbrev=0)
REVISION   	:= $(shell git rev-parse --short HEAD)
GOVERSION  	:= $(shell go version | cut -d ' ' -f3 | sed 's/^go//')
LDFLAGS    	:= -s -X 'main.gVersion=$(VERSION)' \
                -X 'main.gGitcommit=$(REVISION)' \
                -X 'main.gGoversion=$(GOVERSION)'

.PHONY: all
all: help

.PHONY: help
help:
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY:deps
deps: ## Install dependencies
	@go get -u -insecure -v github.com/golang/dep/cmd/dep
	@go get -u -insecure -v github.com/golang/lint/golint
	@go get -u -insecure -v github.com/client9/misspell/cmd/misspell
	@go get -u -insecure -v github.com/gordonklaus/ineffassign
	@go get -u -insecure -v github.com/fzipp/gocyclo
	@go get -u -insecure -v github.com/tsenart/vegeta
	@go get -u -insecure -v github.com/hirokidaichi/goviz
	@go get -u -insecure -v github.com/rs/jplot

.PHONY:build
build: ## Build program
	CGO_ENABLED=0 go build -ldflags "$(LDFLAGS)" -o ./bin/$(NAME) $(BUILD_PATH)

.PHONY:run
run: ## Run program
	go run $(BUILD_PATH)

.PHONY:test
test: golint misspell ineffassign gocyclo vet fmt ## Run all linter & tests
	@$(foreach pkg,$(PKGS),go test -cover -v $(pkg) || exit;)

.PHONY:vet
vet: # linter vet
	@$(foreach pkg,$(PKGS),go vet $(pkg) || exit;)

.PHONY:fmt
fmt: # linter fmt
	@$(foreach file,$(SRCS),go fmt $(file) || exit;)

.PHONY:golint
golint: # linter golint
	@$(foreach file,$(SRCS),golint --set_exit_status $(file) || exit;)

.PHONY:misspell
misspell: # linter misspell
	@$(foreach file,$(DOCS),misspell -error $(file) || exit;)
	@$(foreach file,$(SRCS),misspell -error $(file) || exit;)

.PHONY:ineffassign
ineffassign: # linter ineffassign
	@$(foreach file,$(SRCS),ineffassign $(file) || exit;)

.PHONY:gocyclo
gocyclo: # linter gocyclo
	@$(foreach pkg,$(PKGS),gocyclo -over 15 $(pkg) || exit;)

.PHONY:clean
clean: ## Delete generated files
	-@find . -name '*~' -print | xargs rm
	-@rm -rf go-dev-sample coverage.out goviz.png vendor


