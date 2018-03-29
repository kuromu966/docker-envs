FROM centos:7

###############################################################
# python dependencies
###############################################################
RUN yum -y install kernel-devel \
kernel-headers \
gcc \
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
tk-devel \
zip \
curl \
wget \
tar \
gdbm-devel \
unzip


###############################################################
# python library dependencies
###############################################################

# Machine Learning and scientific calculation
RUN yum -y install gcc-gfortran \
blas-devel \
lapack-devel \
lapack-devel \
freetype \
freetype-devel \
libpng-devel


###############################################################
# Python Install
###############################################################

# set insecure option
RUN echo "check_certificate = off" >> /etc/wgetrc

# pyenv
WORKDIR /root
ENV HOME /root
ENV PYENV_ROOT $HOME/.pyenv
ENV PYTHON_BUILD_CURL_OPTS --insecure
ENV PATH $PYENV_ROOT/bin:$PATH
RUN git config --global http.sslVerify false \
&& git clone https://github.com/yyuu/pyenv.git ~/.pyenv \
&& echo 'eval "$(pyenv init -)"' >> ~/.bashrc

# python
# RUN pyenv install -v 3.6.3 || cat /tmp/python-build.*
RUN eval "$(pyenv init -)" \
&& pyenv install -v 3.6.3 \
&& pyenv global 3.6.3
RUN pyenv rehash

# library
RUN eval "$(pyenv init -)" \
&& pip install --upgrade pip \
&& pip install jupyter \
&& pip install numpy \
&& pip install scipy \
&& pip install scikit-learn \
&& pip install python_dateutil \
&& pip install pyparsing \
&& pip install matplotlib \
&& pip install networkx \
&& pip install blist \
&& pip install seaborn \
&& pip install ipywidgets \
&& pip install dask \
&& pip install pulp \
&& pip install openopt \
&& pip install mypulp \
&& pip install graphviz \
&& pip install bokeh \
&& pip install pandas \
&& pip install blaze \
&& pip install statsmodels \
&& pip install patsy \
&& pip install pydotplus \
&& pip install plotly \
&& pip install pyprind \
&& pip install nltk 
#&& pip install theano
#&& pip install Keras


###############################################################
# Closing
###############################################################
RUN pyenv rehash
RUN rm /etc/wgetrc

