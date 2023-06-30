FROM ubuntu:20.04 as komodod-base
LABEL maintainer="smk@komodoplatform.com"

# Setup up user and working directory
ARG DEBIAN_FRONTEND=noninteractive 
ARG BUILD_PACKAGES="libevent-dev libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-program-options-dev curl \
        libboost-test-dev libboost-thread-dev build-essential pkg-config libc6-dev m4 g++-multilib autoconf libtool ncurses-dev python3-zmq \
        zlib1g-dev wget bsdmainutils automake cmake clang libsodium-dev libcurl4-gnutls-dev libssl-dev git unzip python jq htop"

# Copy entrypoint and build script
COPY entrypoint.sh /entrypoint.sh
COPY build.sh /build.sh

# Install dependencies
RUN apt update && \
    apt install $BUILD_PACKAGES -y

# Build 
RUN /build.sh

# Move binaries
RUN cp /temp/komodo/src/komodo-cli /usr/local/bin/komodo-cli && \
    cp /temp/komodo/src/komodod /usr/local/bin/komodod && \
    PATH=/usr/local/bin/:$PATH

# Cleanup
RUN apt remove --purge -y $BUILD_PACKAGES $(apt-mark showauto) && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /temp/komodo && \
    apt update && apt install -y nano htop libgomp1

ENTRYPOINT ["/entrypoint.sh"]
