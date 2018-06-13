#!/bin/bash -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR/../

cd terraform/


terraform init
terraform apply -auto-approve .

#terraform output kubeconfig > kubeconfig.yaml
#terraform output config-map-aws-auth > config-map-aws-auth.yaml
