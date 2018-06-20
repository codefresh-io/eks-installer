#!/bin/bash -e

CF_API_HOST="${CF_API_HOST:-https://g.codefresh.io}"

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR/../

REQUIRED_ENV_VARS=(
    "CF_API_KEY"
    "K8S_NAME"
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

if [[ "$EXISTING_CLUSTER_ID" == "" ]]; then
    echo "Error: cluster does not exist. Exiting"
    exit 1
fi

echo "Deleting cluster (id=$EXISTING_CLUSTER_ID)..."
curl -s --fail -X DELETE \
-H "x-access-token: $CF_API_KEY" \
"$CF_API_HOST/api/clusters/local/cluster/$EXISTING_CLUSTER_ID"
