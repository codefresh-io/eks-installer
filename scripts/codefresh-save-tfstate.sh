#!/bin/bash -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR/../

export TFSTATE_BASE64="$(cat terraform/terraform.tfstate | base64 | tr -d '\n')"

sed "s/TFSTATE_BASE64:.*/TFSTATE_BASE64: \"$TFSTATE_BASE64\"/g; s/eks-install/eks-install-$CLUSTER_NAME/g" \
    eks-install-context-template.yaml > eks-install-context.yaml

codefresh patch context -f eks-install-context.yaml
