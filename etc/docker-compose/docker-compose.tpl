version: '2'
services:
  data:
    container_name: %%DATA_CONTAINER%%
    image: busybox
    image: %%BASE_IMAGE%%
    volumes:
      - ./:%%MOUNT_POINT%%
      
  gcc:
    image: %%GCC_IMAGE%%
    container_name: %%GCC_CONTAINER%%
    build: etc/docker-compose/images/gcc/
    security_opt:
      - seccomp:unconfined
    volumes_from:
      - data
    working_dir: %%MOUNT_POINT%%/src
    tty: true
  gcc-build:
    image: %%GCC_IMAGE%%
    build: etc/docker-compose/images/gcc/
    volumes_from:
      - data
    working_dir: /usr/local/docker
    command: make _build-gcc
    tty: true
  gcc-run:
    image: %%GCC_IMAGE%%
    build: etc/docker-compose/images/gcc/
    volumes_from:
      - data
    working_dir: %%MOUNT_POINT%%/src
    tty: true

  python3:
    image: %%PYTHON3_IMAGE%%
    container_name: %%PYTHON3_CONTAINER%%
    build: etc/docker-compose/images/python3/
    security_opt:
      - seccomp:unconfined
    volumes_from:
      - data
    working_dir: %%MOUNT_POINT%%/src
    tty: true
  python3-run:
    image: %%PYTHON3_IMAGE%%
    build: etc/docker-compose/images/python3/
    volumes_from:
      - data
    working_dir: %%MOUNT_POINT%%/src
    tty: true
  python3-jupyter:
    image: %%PYTHON3_IMAGE%%
    build: etc/docker-compose/images/python3/
    volumes_from:
      - data
    ports:
      - %%JUPYTER_PORT%%:8888
    working_dir: %%MOUNT_POINT%%/src/%%JUPYTER_PATH%%
    tty: true

  ruby:
    image: %%RUBY_IMAGE%%
    container_name: %%RUBY_CONTAINER%%
    build: etc/docker-compose/images/ruby/
    security_opt:
      - seccomp:unconfined
    volumes_from:
      - data
    working_dir: %%MOUNT_POINT%%/src
    tty: true
  ruby-run:
    image: %%RUBY_IMAGE%%
    build: etc/docker-compose/images/ruby/
    volumes_from:
      - data
    working_dir: %%MOUNT_POINT%%/src
    tty: true

  perl:
    image: %%PERL_IMAGE%%
    container_name: %%PERL_CONTAINER%%
    build: etc/docker-compose/images/perl/
    security_opt:
      - seccomp:unconfined
    volumes_from:
      - data
    working_dir: %%MOUNT_POINT%%/src
    tty: true
  perl-run:
    image: %%PERL_IMAGE%%
    build: etc/docker-compose/images/perl/
    volumes_from:
      - data
    working_dir: %%MOUNT_POINT%%/src
    tty: true
    
  go:
    image: %%GO_IMAGE%%
    container_name: %%GO_CONTAINER%%
    build: etc/docker-compose/images/go/
    security_opt:
      - seccomp:unconfined
    volumes_from:
      - data
    working_dir: %%MOUNT_POINT%%/src
    tty: true
  go-deps:
    image: %%GO_IMAGE%%
    build: etc/docker-compose/images/go/
    volumes_from:
      - data
    working_dir: %%MOUNT_POINT%%
    command: make _deps-go
    tty: true
  go-build:
    image: %%GO_IMAGE%%
    build: etc/docker-compose/images/go/
    volumes_from:
      - data
    working_dir: %%MOUNT_POINT%%
    command: make _build-go
    tty: true
  go-run:
    image: %%GO_IMAGE%%
    build: etc/docker-compose/images/go/
    volumes_from:
      - data
    working_dir: %%MOUNT_POINT%%/src
    tty: true

