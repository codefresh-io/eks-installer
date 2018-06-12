#!/bin/bash -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR

docker run -it --rm --entrypoint=sh \
    -v "$HOME/.aws:/root/.aws" \
    -v "$PWD/terraform:/terraform" \
    -w /terraform \
    hashicorp/terraform:0.11.7 \
    -xc "terraform init && terraform apply -auto-approve ."
