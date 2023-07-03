#!/bin/bash

# Get repo and commit
if test -z "$1"; then
  read -p "Which repo? : " repo
else
  repo=$1
fi
if test -z "$2"; then
  read -p "Which branch/commit? : " commit
else
  commit=$2
fi

# Update submodules
git submodule sync
git submodule update --init --recursive --remote

# Prepare repo
echo "Preparing ${repo} on ${commit}..."
cd $repo
git checkout $commit
short_commit=$(git log -1 --pretty="format:%h")

# Build
if [ "${repo}" == "komodo" ]; then
  ./zcutil/fetch-params.sh
  ./zcutil/build.sh -j6
fi

# Get dockerhub credentials. You can set them in ~/.bashrc or here.
if test -z "$DOCKER_USER"; then
  read -p "Enter your dockerhub username: " DOCKER_USER
fi
if test -z "$DOCKER_PASS"; then
  read -p "Enter your dockerhub password: " DOCKER_PASS
fi

# Push to dockerhub
docker login -u ${DOCKER_USER} -p ${DOCKER_PASS}
docker build -f Dockerfile.komodod -t ${DOCKER_USER}/${repo}:${short_commit} .
docker push ${DOCKER_USER}/${repo}:${short_commit}
