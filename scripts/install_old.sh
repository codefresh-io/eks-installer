#!/bin/bash -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR/../

docker run -it --rm --entrypoint=sh \
    -v "$HOME/.aws:/root/.aws" \
    -v "$PWD/terraform:/terraform" \
    -w /terraform \
    hashicorp/terraform:0.11.7 \
    -xc "terraform init && terraform apply -auto-approve ."

docker run -it --rm --entrypoint=sh \
    -v "$HOME/.aws:/root/.aws" \
    -v "$PWD/terraform:/terraform" \
    -w /terraform \
    hashicorp/terraform:0.11.7 \
    -c "terraform output kubeconfig" > kubeconfig.yaml

docker run -it --rm --entrypoint=sh \
    -v "$HOME/.aws:/root/.aws" \
    -v "$PWD/terraform:/terraform" \
    -w /terraform \
    hashicorp/terraform:0.11.7 \
    -c "terraform output config-map-aws-auth" > config-map-aws-auth.yaml

docker run -it --rm --entrypoint=sh \
    -v "$HOME/.aws:/root/.aws" \
    -v "$PWD/kubeconfig.yaml:/root/.kube/config" \
    -v "$PWD/config-map-aws-auth.yaml:/config-map-aws-auth.yaml" \
    lachlanevenson/k8s-kubectl:v1.10.4 \
    -xc "wget https://amazon-eks.s3-us-west-2.amazonaws.com/1.10.3/2018-06-05/bin/linux/amd64/heptio-authenticator-aws && \
         chmod +x ./heptio-authenticator-aws && \
         mv heptio-authenticator-aws /usr/local/bin && \
         kubectl apply -f /config-map-aws-auth.yaml"

