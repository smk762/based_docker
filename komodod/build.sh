#!/bin/bash
set -euxo pipefail
echo $PWD
echo "========================================"
git clone https://github.com/KomodoPlatform/komodo
cd komodo && git checkout 156dba6

./zcutil/build.sh -j$(nproc -1)
