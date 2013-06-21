#!/bin/bash -ex

CF_RELEASE_URL=${CF_RELEASE_URL:-https://github.com/cloudfoundry/cf-release.git}
CF_RELEASE_BRANCH=${CF_RELEASE_BRANCH:-ea61ec6f8f}

if [ ! -d cf-release ]; then
    git clone ${CF_RELEASE_URL}
    (
        cd cf-release
        git checkout ${CF_RELEASE_BRANCH}
        git submodule foreach --recursive git submodule sync && git submodule update --init --recursive
        bosh -n create release --force
    )
fi
