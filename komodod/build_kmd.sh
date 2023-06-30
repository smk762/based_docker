#!/bin/bash
set -euxo pipefail
echo $PWD
echo "========================================"
mkdir -p /temp
cd /temp
git clone https://github.com/KomodoPlatform/komodo
cd komodo && git checkout ${1}
./zcutil/build.sh -j$(4)
