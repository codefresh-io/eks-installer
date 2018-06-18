#!/bin/bash -e

CLUSTER_NAME="${CLUSTER_NAME:-terraform-eks-demo}"

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR/../

cd terraform/

terraform init
terraform destroy -auto-approve -var "cluster-name=${CLUSTER_NAME}" .
