#!/bin/bash -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR/../

set -o pipefail

codefresh get context eks-install -o json | \
    jq -r '.spec.data.TFSTATE_BASE64' | \
    sed -e 's/^null$$//' | \
    base64 -d > terraform/terraform.tfstate
