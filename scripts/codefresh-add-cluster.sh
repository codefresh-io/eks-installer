#!/bin/bash -e

CLUSTER_NAME="${CLUSTER_NAME:-terraform-eks-demo}"
CF_API_HOST="${CF_API_HOST:-https://g.codefresh.io}"

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR/../

REQUIRED_ENV_VARS=(
    "CF_API_KEY"
    "K8S_NAME"
    "K8S_HOST"
    "K8S_CA"
    "K8S_TOKEN"
)

for VAR in ${REQUIRED_ENV_VARS[@]}; do
    if [ "${!VAR}" == "" ]; then
        echo "Env missing ${VAR}"
        echo "Must have: ${REQUIRED_ENV_VARS[@]}"
        exit 1
    fi
done

echo "Checking if cluster \"$K8S_NAME\" already exists..."
EXISTING_CLUSTER_ID=$(curl -s \
    -H "x-access-token: $CF_API_KEY" \
    "$CF_API_HOST/api/clusters" | \
    jq -r ".[] | select(. | .selector == \"$K8S_NAME\") | ._id")

if [[ "$EXISTING_CLUSTER_ID" != "" ]]; then
    echo "Cluster already exists, deleting (id=$EXISTING_CLUSTER_ID)..."
    curl -s --fail -X DELETE \
    -H "x-access-token: $CF_API_KEY" \
    "$CF_API_HOST/api/clusters/local/cluster/$EXISTING_CLUSTER_ID"
fi

echo "Adding new cluster \"$K8S_NAME\"..."
curl -s --fail \
    -H "x-access-token: $CF_API_KEY" \
    -H "content-type: application/json;charset=UTF-8" \
    -d \
    "{
        \"type\": \"sat\",
        \"selector\": \"$K8S_NAME\",
        \"host\": \"$K8S_HOST\",
        \"clientCa\": \"$K8S_CA\",
        \"serviceAccountToken\": \"$K8S_TOKEN\",
        \"provider\": \"local\",
        \"providerAgent\": \"eks\"
    }" \
    "$CF_API_HOST/api/clusters/local/cluster"
echo
