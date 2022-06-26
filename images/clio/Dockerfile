FROM ubuntu:20.04 as build

ARG VERSION=0.2.0
ARG DEBIAN_FRONTEND=noninteractive

RUN export LANGUAGE=C.UTF-8; export LANG=C.UTF-8; export LC_ALL=C.UTF-8

COPY entrypoint.sh .

RUN apt-get -y update && \
apt-get -y install \
git \
pkg-config \
protobuf-compiler \
libprotobuf-dev \
libssl-dev \
wget \
build-essential \
bison \
flex \
autoconf \
cmake 

RUN wget -q -O $HOME/boost_1_75_0.tar.gz https://boostorg.jfrog.io/artifactory/main/release/1.75.0/source/boost_1_75_0.tar.gz && \
    tar -xzf $HOME/boost_1_75_0.tar.gz -C $HOME && \
    cd $HOME/boost_1_75_0 && \
    ./bootstrap.sh && \
    ./b2 -j$(nproc)

RUN git clone --single-branch --branch "${VERSION}" https://github.com/XRPLF/clio.git /opt/clio

WORKDIR /opt/clio

COPY ./config.json /opt/clio

RUN echo "export BOOST_ROOT=$HOME/boost_1_75_0" >> $HOME/.profile && \
    /bin/bash -c "source $HOME/.profile" && \
    cmake -B build && \
    cmake --build build --parallel $(nproc)

FROM ubuntu:20.04
COPY --from=build /opt/clio/ /opt/clio/

RUN export LANGUAGE=C.UTF-8; export LANG=C.UTF-8; export LC_ALL=C.UTF-8

RUN apt-get -y update && \
apt-get -y install \
libboost-all-dev \
net-tools \
curl \
jq \
netcat

RUN ls -la /opt/clio

ENTRYPOINT [ "entrypoint.sh" ]

