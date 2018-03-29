FROM %%BASE_IMAGE%%

###############################################################
# Perl dependencies
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
# Perl library dependencies
###############################################################

#TODO

###############################################################
# Perl Install
###############################################################

# set insecure option
RUN echo "check_certificate = off" >> /etc/wgetrc
RUN echo 'insecure' >> ~/.curlrc

# plenv
WORKDIR /root

RUN git config --global http.sslVerify false \
&& git clone https://github.com/tokuhirom/plenv.git ~/.plenv/ \
&& git clone https://github.com/tokuhirom/Perl-Build.git ~/.plenv/plugins/perl-build/

ENV PATH /root/.plenv/bin:$PATH
ENV PATH /root/.plenv/shims:$PATH
RUN echo 'export PATH=~/.plenv/bin:~/.plenv/shims/:$PATH'
RUN echo 'eval "$(plenv init -)"' >> ~/.bashrc

# perl
RUN eval "$(plenv init -)" \
&& plenv install %%PERL_VERSION%% \
&& plenv global %%PERL_VERSION%% \
&& plenv install-cpanm \
&& plenv rehash

# library
RUN eval "$(plenv init -)" \
&& cpanm Mojolicious \
&& cpanm Mojo \
&& plenv rehash


###############################################################
# Closing
###############################################################
RUN rm /etc/wgetrc
RUN rm ~/.curlrc

