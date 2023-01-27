#!/usr/bin/env bash

set -xue

# Usage: $0 $KUBECTL_VER. e.g: $0 v1.25.6

for ARCH in amd64 arm64
do
    mkdir -p "${ARCH}"
    pushd "${ARCH}"
    curl -sSfL https://dl.k8s.io/release/"${1?required}"/bin/linux/"${ARCH}"/kubectl -o kubectl
    curl -sSfL https://dl.k8s.io/release/"${1?required}"/bin/linux/"${ARCH}"/kubectl.sig -o kubectl.sig
    curl -sSfL https://dl.k8s.io/release/"${1?required}"/bin/linux/"${ARCH}"/kubectl.cert -o kubectl.cert
    COSIGN_EXPERIMENTAL=1 cosign verify-blob kubectl --signature kubectl.sig --certificate kubectl.cert
    popd
done
