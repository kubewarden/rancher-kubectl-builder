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
    cosign verify-blob --signature kubectl.sig --certificate kubectl.cert kubectl \
        --certificate-identity krel-staging@k8s-releng-prod.iam.gserviceaccount.com \
        --certificate-oidc-issuer https://accounts.google.com
    popd
done
