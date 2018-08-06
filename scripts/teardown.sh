#!/bin/bash -e

CLUSTER_NAME="${CLUSTER_NAME:-terraform-eks-demo}"
CLUSTER_SIZE="${CLUSTER_SIZE:-1}"
CLUSTER_REGION="${CLUSTER_REGION:-us-west-2}"
CLUSTER_INSTANCE_TYPE="${CLUSTER_INSTANCE_TYPE:-m4.large}"
KEY_PAIR_NAME="${KEY_PAIR_NAME:-default}"
KEY_PAIR_PUBLIC_KEY="${CLUSTER_REGION:-default}"

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR/../

cd terraform/

terraform init
terraform destroy -auto-approve \
    -var "cluster-name=${CLUSTER_NAME}" \
    -var "key-pair-name=${KEY_PAIR_NAME}" \
    -var "key-pair-public-key=${KEY_PAIR_PUBLIC_KEY}" \
    -var "cluster-size=${CLUSTER_SIZE}" \
    -var "cluster-region=${CLUSTER_REGION}" \
    -var "cluster-instance-type=${CLUSTER_INSTANCE_TYPE}" \
    .
