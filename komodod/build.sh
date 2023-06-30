#!/bin/bash
set -euxo pipefail
echo $PWD
echo "========================================"
git clone https://github.com/KomodoPlatform/komodo
cd komodo && git checkout 156dba6 && \
./autogen.sh && \
./configure --with-incompatible-bdb --with-gui || true && \
./zcutil/build.sh -j$(nproc -1)
