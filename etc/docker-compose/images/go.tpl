FROM %%BASE_IMAGE%%

###############################################################
# Go dependencies
###############################################################
RUN yum -y install gcc \
gcc-c++ \
automake \
make \
patch \
git \
openssl-devel \
zlib \
zlib-devel \
bzip2 \
bzip2-devel \
readline \
readline-devel \
sqlite \
sqlite-devel \
openssl \
openssl-devel \
libyaml-devel \
libffi-devel \
libtool \
bison \
zip \
curl \
wget \
tar \
unzip


###############################################################
# Go library dependencies
###############################################################

RUN yum -y install graphviz \
graphviz-devel \
graphviz-gd

###############################################################
# Go Install
###############################################################

# set insecure option
RUN echo "check_certificate = off" >> /etc/wgetrc
RUN echo 'insecure' >> ~/.curlrc

# goenv
WORKDIR /root
RUN git config --global http.sslVerify false \
&& git clone https://github.com/syndbg/goenv.git ~/.goenv
ENV PATH /root/.goenv/bin:$PATH
ENV PATH /root/.goenv/shims:$PATH
ENV PATH %%GO_PATH%%:$PATH
ENV GOPATH %%GO_PATH%%
RUN mkdir -p %%GO_PATH%%
RUN echo 'export GOENV_ROOT=$HOME/.goenv' >> ~/.bashrc
RUN echo 'export GOPATH=%%GO_PATH%%' >> ~/.bashrc
RUN echo 'export PATH=$GOENV_ROOT/bin:$GOPATH/bin:$PATH' >> ~/.bashrc
RUN echo 'eval "$(goenv init -)"' >> ~/.bashrc

# go
RUN eval "$(goenv init -)" \
&& goenv install %%GO_VERSION%% \
&& goenv global %%GO_VERSION%% \
&& goenv rehash

###############################################################
# Closing
###############################################################
RUN rm /etc/wgetrc
RUN rm ~/.curlrc

