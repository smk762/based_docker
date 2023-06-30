FROM ubuntu:20.04
LABEL maintainer="smk@komodoplatform.com"

# Install dependencies
ARG DEBIAN_FRONTEND=noninteractive 
ARG BUILD_PACKAGES="libevent-dev libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-program-options-dev curl \
        libboost-test-dev libboost-thread-dev build-essential pkg-config libc6-dev m4 g++-multilib autoconf libtool ncurses-dev python3-zmq \
        zlib1g-dev wget bsdmainutils automake cmake clang libsodium-dev libcurl4-gnutls-dev libssl-dev git unzip python jq htop"
RUN apt update && apt install $BUILD_PACKAGES -y

# Build 
WORKDIR /build
COPY build.sh /build.sh
RUN /build.sh master

# Move binaries
RUN cp /build/komodo/src/komodo-cli /usr/local/bin/komodo-cli && \
    cp /build/komodo/src/komodod /usr/local/bin/komodod && \
    PATH=/usr/local/bin/:$PATH

# Cleanup
RUN rm -rf /build/komodo && \
    apt remove --purge -y $BUILD_PACKAGES $(apt-mark showauto) && \
    rm -rf /var/lib/apt/lists/* && \
    apt update && apt install -y nano htop libgomp1

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
