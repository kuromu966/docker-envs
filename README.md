# docker-envs

## Overview

docker-envsはDockerを利用した各言語の開発環境を提供します。

これを利用することで、開発者はDockerやDocker-Composeさえsetupしていれば、任意の環境でのsoftware開発が可能になります。またその環境を共有することも簡単に行うことができます。

Supportしている言語は`C`、`C++`、`Python3`、`Ruby`、`GO`です。


## Prerequisite

- Docker-Compose、Dockerをinstall済みであること


## Files

### Makefile

大抵の設定はTop DirectoryのMakefileの中に記載されています。

Parameter | default | Description
--------- | ------- | ------------
BASE_IMAGE | centos:7 | Containerが利用するBaseとなるImageです。Dockerfileがimageを指定するのと同じformatで指定してください。
BOOST_VERSION | 1.66.0 | C++で利用するBoostのversionを指定します。

**注意** Imageはcentosを利用することを想定しています。

その他のImageを使う場合はDockerfileの書き換えが必要になりますが、その作業は各人が行う必要があります。(たとえばyumなどは使えなくなるのでerrorを吐くでしょう)

### .docker-compose.yml

docker-compose commandが利用する設定fileです。この中に起動させたいserviceと対応するcontainerの定義がYAML形式で記述されています。

`/etc/docker-compose/docker-compose.tpl`を元にTop DirectoryのMakefileにより生成されます。

### /src/*

source fileです。dockerの`/usr/local/docker/`はhostの`./src`をmount pointとしています。

開発はここで行います。


### その他

**yumで他のpackageをinstallしたい場合**

Dockerfileを書き換えてください。




## C/C++

GCCの他にlibraryとしてboost、debug toolとしてstrace、gdb、valgrindをinstallしたimageを用意してあります。

- Dockerfile Template => `/etc/docker-compose/images/gcc.tpl`

### Version

Name | Default | Description
---- | ------- | -------------
GCC | 7.x | devtoolset-7に用意されているversionがinstallされます
BOOST | 1.66.0 | Makefileの`BOOST_VERSION`で指定します


### 使い方

**docker containerの起動**

```
$ make dup-gcc
```

**docker containerへのlogin**

```
$ make login-gcc
```

**C++のbuild**

`/src/sample-cpp/`にあるsource codeが、docker container内でbuildされます。

containerは専用に起動し、作業終了と同時に削除されます。


```
$ make build-gcc
```

**buildしたfileの実行**

`/src/sample-cpp/bin/sample`として作られた実行fileをdocker container内で実行します。

containerは専用に起動し、作業終了と同時に削除されます。

```
$ make sample-gcc
```


## Python3

- Dockerfile Template =>  `/etc/docker-compose/images/python3.tpl`

Python3は科学系算用libraryやデータ解析用library、そしてjupyterをinstallしたimageを用意してあります。

### Version

Name | Default | Description
---- | ------- | -------------
Python | 3.6.3 | Makefileの`PYTHON3_VERSION`で指定します



### 使い方

**docker containerの起動**

```
$ make dup-python3
```

**docker containerへのlogin**

```
$ make login-python3
```

**実行**

`/src/sample-pythno3/sample.py`として作られた実行fileをdocker container内で実行します。

containerは専用に起動し、作業終了と同時に削除されます。

```
$ make sample-python3
```

### Jupyterの利用方法

**port**

Defaultでport 8000番を利用します。

変更したい場合はMakefileの`JUPYTER_PORT`で指定してください。

**workdirectory**

Defaultで`./src/jupyter`以下を利用します。

変更したい場合はMakefileの`JUPYTER_PATH`で指定してください。


**実行**

以下のcommandを実行してください。

```
$ make jupyter
```

その後以下のような画面が出ます。

```
$ make jupyter
Starting host_mounter ... done
[I 04:32:36.306 NotebookApp] Writing notebook server cookie secret to /root/.local/share/jupyter/runtime/notebook_cookie_secret
[I 04:32:36.821 NotebookApp] Serving notebooks from local directory: /usr/local/docker/src/jupyter
[I 04:32:36.821 NotebookApp] 0 active kernels
[I 04:32:36.822 NotebookApp] The Jupyter Notebook is running at:
[I 04:32:36.822 NotebookApp] http://0.0.0.0:8888/?token=345a37b4a76d40f83b0d1cb713924c7370e78f65eaf118c3
[I 04:32:36.822 NotebookApp] Use Control-C to stop this server and shut down all kernels (twice to skip confirmation).
[W 04:32:36.824 NotebookApp] No web browser found: could not locate runnable browser.
[C 04:32:36.825 NotebookApp]

    Copy/paste this URL into your browser when you connect for the first time,
    to login with a token:
        http://0.0.0.0:8888/?token=345a37b4a76d40f83b0d1cb713924c7370e78f65eaf118c3
```

最後に出てくる`http://0.0.0.0:8888/?token=345a37b4a76d40f83b0d1cb713924c7370e78f65eaf118c3`のうち、`?token=`以降を利用します。

hostのborwserで`http://localhost:8000/?token=345a37b4a76d40f83b0d1cb713924c7370e78f65eaf118c3`を表示してください。

以後jupyter環境で作業可能です。


## Ruby

- Dockerfile Template =>  `/etc/docker-compose/images/ruby.tpl`

Rubyには特にdefaultでinstallされているgem packageはありません。

### Version

Name | Default | Description
---- | ------- | -------------
Ruby | 2.4.2 | Makefileの`RUBY_VERSION`で指定します



### 使い方

**docker containerの起動**

```
$ make dup-ruby
```

**docker containerへのlogin**

```
$ make login-ruby
```

**実行**

`/src/sample-ruby/sample.rb`として作られた実行fileをdocker container内で実行します。

containerは専用に起動し、作業終了と同時に削除されます。

```
$ make sample-ruby
```


## Perl

- Dockerfile Template =>  `/etc/docker-compose/images/perl.tpl`

PerlはMojoliciousをinstallしたimageを用意してあります。

### Version

Name | Default | Description
---- | ------- | -------------
Perl | 5.26.1 | Makefileの`PERL_VERSION`で指定します



### 使い方

**docker containerの起動**

```
$ make dup-perl
```

**docker containerへのlogin**

```
$ make login-perl
```

**実行**

`/src/sample-perl/sample.pl`として作られた実行fileをdocker container内で実行します。

containerは専用に起動し、作業終了と同時に削除されます。

```
$ make sample-pl
```

## Go

- Dockerfile Template =>  `/etc/docker-compose/images/go.tpl`

### Version

Name | Default | Description
---- | ------- | -------------
Go | 1.10.0 | Makefileの`GO_VERSION`で指定します



### 使い方

**docker containerの起動**

```
$ make dup-go
```

**docker containerへのlogin**

```
$ make login-go
```

**依存関係のあるmoduleのinstall**

Goで利用するmoduleが事前にわかっている場合、以下のcommandでinstallできます。

```
$ make deps
```

このcommandは`./src/sample-go/Makefile`の`make deps`を叩いています。実際に必要となるmoduleのinstall commandはここに定義されています。



**Build**

GOのSource File Pathは`Makefile`の`GO_PATH`に定義されています。

実際にどのfileを起点としてbuildするかは、今回の開発対象となる`./src/sample-go/Makefile`の中に`BUILD_PATH`として定義されています。

今回は`/src/sample-go/src/github.com/sample/sample.go`を対象とします。

```
$ make build-go
```

これで`/src/sample-go/bin/hello`が生成されます。

**実行**

`/src/sample-go/src/github.com/sample/sample.go`から作られた実行fileをdocker container内で実行します。

containerは専用に起動し、作業終了と同時に削除されます。

```
$ make sample-go
```


## memo

### Docker Commands

- `docker build -t py3 ./path/to/Dockerfile/Directory` 指定されたdirectoryにあるDockerfileでpy3というimageを作成します
- `docker run --it --name test py3 /bin/bash` py3というimageでtestというcontainerを作り/bin/bashを実行します
- `docker ps -a` container一覧を表示します
- `docker rm {container or id}` containerを削除します
- `docker iamges` image一覧を表示します
- `docker rmi {image or id}` containerを削除します
