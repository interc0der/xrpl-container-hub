FROM ubuntu:20.04 as build

ARG CLIO_VERSION=0.2.0
ARG BOOST_VERSION=75
ARG DEBIAN_FRONTEND=noninteractive

RUN export LANGUAGE=C.UTF-8; export LANG=C.UTF-8; export LC_ALL=C.UTF-8

RUN apt-get -y update && \
apt-get -y install \
git \
pkg-config \
protobuf-compiler \
libprotobuf-dev \
libssl-dev \
wget \
g++-10 \
bison \
flex \
autoconf \
cmake

RUN rm /usr/bin/gcc && ln -s /usr/bin/gcc-10 /usr/bin/gcc && ln -s /usr/bin/g++-10 /usr/bin/g++
RUN wget -q -O /boost_1_${BOOST_VERSION}_0.tar.gz https://boostorg.jfrog.io/artifactory/main/release/1.${BOOST_VERSION}.0/source/boost_1_${BOOST_VERSION}_0.tar.gz && \
    tar -xzf /boost_1_${BOOST_VERSION}_0.tar.gz

RUN cd /boost_1_${BOOST_VERSION}_0 && ./bootstrap.sh && \
    ./b2 -j$(nproc)
ENV BOOST_ROOT=/boost_1_${BOOST_VERSION}_0

WORKDIR /opt/clio
RUN git clone  --depth 1 --branch "${CLIO_VERSION}" https://github.com/XRPLF/clio.git .

RUN cmake -B build && cmake --build build --parallel $(nproc)

FROM ubuntu:20.04
WORKDIR /opt/clio
RUN apt-get update && apt-get -y install vim net-tools curl jq netcat
RUN export LANGUAGE=C.UTF-8; export LANG=C.UTF-8; export LC_ALL=C.UTF-8

COPY --from=build /opt/clio/build/clio_server .
COPY --from=build /opt/clio/build/clio_tests .
COPY config.json .
COPY entrypoint.sh .

CMD [ "./entrypoint.sh" ]
