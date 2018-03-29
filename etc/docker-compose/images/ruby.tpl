FROM %%BASE_IMAGE%%

###############################################################
# Ruby dependencies
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
# Ruby library dependencies
###############################################################

#TODO

###############################################################
# Ruby Install
###############################################################

# set insecure option
RUN echo "check_certificate = off" >> /etc/wgetrc
RUN echo 'insecure' >> ~/.curlrc

# rbenv
WORKDIR /root

RUN git config --global http.sslVerify false \
&& git clone https://github.com/sstephenson/rbenv.git /root/.rbenv \
&& git clone https://github.com/sstephenson/ruby-build.git /root/.rbenv/plugins/ruby-build
ENV PATH /root/.rbenv/bin:$PATH
RUN echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh
RUN echo 'eval "$(rbenv init -)"' >> .bashrc

# ruby
ENV CONFIGURE_OPTS --disable-install-doc
ENV RUBY_BUILD_CURL_OPTS --insecure
RUN rbenv install -v %%RUBY_VERSION%% \
&& rbenv global %%RUBY_VERSION%%
RUN rbenv rehash

# library

#TODO

###############################################################
# Closing
###############################################################
RUN rbenv rehash
RUN rm /etc/wgetrc
RUN rm ~/.curlrc

