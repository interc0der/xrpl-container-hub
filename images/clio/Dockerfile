FROM ubuntu:20.04
ARG DEBIAN_FRONTEND=noninteractive

SHELL ["/bin/bash", "-c"]

RUN export LANGUAGE=C.UTF-8; export LANG=C.UTF-8; export LC_ALL=C.UTF-8
USER root

COPY docker-entrypoint.sh /
COPY ./config ./cfg

RUN apt-get -y update

RUN echo "installing dependencies" && \
    apt-get -y install git pkg-config protobuf-compiler libprotobuf-dev libssl-dev wget build-essential bison flex autoconf cmake && \
    wget -q -O $HOME/boost_1_75_0.tar.gz https://boostorg.jfrog.io/artifactory/main/release/1.75.0/source/boost_1_75_0.tar.gz && \
    echo "unzipping boost pkg" && \
    tar -xzf $HOME/boost_1_75_0.tar.gz -C $HOME && \
    cd $HOME/boost_1_75_0 && \
    echo "running boostrap script" && \
    ./bootstrap.sh && \
    echo "running b2 script" && \
    ./b2 -j$(nproc) && \
    echo "export BOOST_ROOT=$HOME/boost_1_75_0" >> $HOME/.profile && \
    source $HOME/.profile && \
    echo "finished building boost ---> clio time"

RUN echo "cloning and building clio from source" && \
    apt-get -y update && \
    cd /opt && \
    echo "cloning clio" && \
    git clone https://github.com/XRPLF/clio.git && \
    cd /opt/clio && \
    apt clean && \
    echo "building clio" && \
    cmake -B build && cmake --build build --parallel $(nproc) && \
    echo "congratulations, you are finished building clio"

ENTRYPOINT ["/docker-entrypoint.sh"]

