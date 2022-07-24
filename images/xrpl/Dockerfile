FROM ubuntu:20.04

RUN export LANGUAGE=C.UTF-8; export LANG=C.UTF-8; export LC_ALL=C.UTF-8; export DEBIAN_FRONTEND=noninteractive

COPY docker-entrypoint.sh /

RUN apt-get -y update

RUN apt-get -y install apt-transport-https ca-certificates wget gnupg && \
    wget -q -O - "https://repos.ripple.com/repos/api/gpg/key/public" | apt-key add - && \
    echo "deb https://repos.ripple.com/repos/rippled-deb focal stable" | tee -a /etc/apt/sources.list.d/ripple.list && \
    apt-get -y update && \
    apt-get -y install rippled && \
    rm -rf /var/lib/apt/lists/* && \
    apt clean && \
    export PATH=$PATH:/opt/ripple/bin/ && \
    chmod +x /docker-entrypoint.sh && \
    echo '#!/bin/bash' > /usr/bin/server_info && echo '/entrypoint.sh server_info' >> /usr/bin/server_info && \
    chmod +x /usr/bin/server_info

RUN ln -s /opt/ripple/bin/rippled /usr/bin/rippled

ENTRYPOINT ["entrypoint.sh"]
