## Courtesy of legleux
## https://github.com/legleux/clio/blob/b4d061fbc3c12b885b1ea14a412d27364c7a3e78/compose-clio-net/clio_docker/Dockerfile
FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive

RUN export LANGUAGE=C.UTF-8; export LANG=C.UTF-8; export LC_ALL=C.UTF-8

RUN apt-get update && \
    apt-get install -y \
    apt-transport-https \
    ca-certificates \
    wget \
    gnupg

RUN mkdir /usr/local/share/keyrings/ && \
    wget -q -O - "https://repos.ripple.com/repos/api/gpg/key/public" | \
    gpg --dearmor > ripple-key.gpg && \
    mv ripple-key.gpg /usr/local/share/keyrings

RUN echo "deb [signed-by=/usr/local/share/keyrings/ripple-key.gpg] https://repos.ripple.com/repos/rippled-deb-test-mirror focal unstable" | \
    tee -a /etc/apt/sources.list.d/clio.list

RUN apt-get update && \
    apt-get install -y clio

WORKDIR /opt/clio
COPY config.json .
COPY entrypoint.sh .

CMD [ "./entrypoint.sh" ]