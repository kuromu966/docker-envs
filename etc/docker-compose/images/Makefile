BASE_IMAGE		:= centos:7
BOOST_VERSION		:= 1.66.0
_BOOST_VERSION		:= $(subst .,_,${BOOST_VERSION})
PYTHON3_VERSION		:= 3.6.3
RUBY_VERSION		:= 2.4.2
PERL_VERSION		:= 5.26.1
GO_VERSION		:= 1.10.0
GO_PATH			:= /usr/local/docker/src/sample-go

all: gcc/Dockerfile python3/Dockerfile ruby/Dockerfile perl/Dockerfile go/Dockerfile

.PHONY: clean
clean: 
	-@find . -name '*~' -print | xargs rm
	-@rm -rf gcc
	-@rm -rf python3
	-@rm -rf ruby
	-@rm -rf perl
	-@rm -rf go

gcc/Dockerfile: gcc.tpl
	-@rm -rf ./gcc
	@mkdir -p ./gcc
	@cat gcc.tpl | \
		sed "s/%%BASE_IMAGE%%/${BASE_IMAGE}/g" | \
		sed "s/%%BOOST_VERSION%%/${BOOST_VERSION}/g" | \
		sed "s/%%_BOOST_VERSION%%/${_BOOST_VERSION}/g" \
		 > gcc/Dockerfile

python3/Dockerfile: python3.tpl
	-@rm -rf ./python3
	@mkdir -p ./python3
	@cat python3.tpl | \
		sed "s/%%BASE_IMAGE%%/${BASE_IMAGE}/g" | \
		sed "s/%%PYTHON3_VERSION%%/${PYTHON3_VERSION}/g" \
		 > python3/Dockerfile

ruby/Dockerfile: ruby.tpl
	-@rm -rf ./ruby
	@mkdir -p ./ruby
	@cat ruby.tpl | \
		sed "s/%%BASE_IMAGE%%/${BASE_IMAGE}/g" | \
		sed "s/%%RUBY_VERSION%%/${RUBY_VERSION}/g" \
		 > ruby/Dockerfile

perl/Dockerfile: perl.tpl
	-@rm -rf ./perl
	@mkdir -p ./perl
	@cat perl.tpl | \
		sed "s/%%BASE_IMAGE%%/${BASE_IMAGE}/g" | \
		sed "s/%%PERL_VERSION%%/${PERL_VERSION}/g" \
		 > perl/Dockerfile

go/Dockerfile: go.tpl
	-@rm -rf ./go
	@mkdir -p ./go
	@cat go.tpl | \
		sed "s/%%BASE_IMAGE%%/${BASE_IMAGE}/g" | \
		sed "s/%%GO_VERSION%%/${GO_VERSION}/g" | \
		sed "s|%%GO_PATH%%|${GO_PATH}|g" \
		 > go/Dockerfile


