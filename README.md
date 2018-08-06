# eks-installer
Tool to setup a new EKS cluster and connect to Codefresh

Please see blog post with full instructions here: https://codefresh.io/kubernetes-tutorial/getting-started-amazon-eks/

## Pipelines
Codefresh pipelines can be found in the `.codefresh/` directory.

The following environment variables are **required**:

- `AWS_ACCESS_KEY_ID` <em>encrypted</em> - AWS access key ID
- `AWS_SECRET_ACCESS_KEY` <em>encrypted</em> - AWS secret access key
- `CLUSTER_NAME` - unique EKS cluster name

The following environment variables are **optional**:

- `CLUSTER_SIZE` - number of nodes in ASG (default: 1)
- `CLUSTER_REGION` - AWS region to deploy to (default: us-west-2)
- `CLUSTER_INSTANCE_TYPE` - EC2 instance type (default: m4.large)
- `CLUSTER_KEY_NAME` - The key name to use for SSH access (default: *None*)


### setup.yml

View YAML: 
[.codefresh/setup.yml](https://github.com/codefresh-io/eks-installer/blob/master/.codefresh/setup.yml)

Does the following:

1. Bootstraps an EKS cluster and VPC in your AWS account using Terraform
2. Saves the Terraform statefile in a Codefresh context
3. Creates some base Kubernetes resources
4. Initializes Helm in the cluster
5. Adds the cluster to your Codefresh account

### teardown.yml

View YAML: 
[.codefresh/teardown.yml](https://github.com/codefresh-io/eks-installer/blob/master/.codefresh/teardown.yml)

Does the following:

1. Loads the Terraform statefile from Codefresh context
2. Destroys the EKS cluster from your AWS account using Terraform
3. Removes the cluster from your Codefresh account

## Useful Links
EKS User Guide:
https://docs.aws.amazon.com/eks/latest/userguide/

Bootstrapping EKS cluster with Terraform:
https://www.terraform.io/docs/providers/aws/guides/eks-getting-started.html

Heptio Authenticator for AWS:
https://github.com/heptio/authenticator

## Credits
The contents of `terraform/` directory based on the official Terraform EKS example found here: https://github.com/terraform-providers/terraform-provider-aws/tree/master/examples/eks-getting-started
