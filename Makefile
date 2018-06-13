.PHONY: install
install:
	@./scripts/install.sh

.PHONY: uninstall
uninstall:
	@./scripts/uninstall.sh

.PHONY: codefresh-save-tfstate
codefresh-save-tfstate:
	@sed -i '' "s/TFSTATE_BASE64:.*/TFSTATE_BASE64: \"$$(cat terraform/terraform.tfstate | base64)\"/g" eks-install-context.yaml
	@codefresh patch context -f eks-install-context.yaml

.PHONY: codefresh-get-tfstate
codefresh-get-tfstate:
	@codefresh get context eks-install -o json | jq -r '.spec.data.TFSTATE_BASE64' | sed -e 's/^null$$//' | base64 -D

.PHONY: codefresh-load-tfstate
codefresh-load-tfstate:
	@codefresh get context eks-install -o json | jq -r '.spec.data.TFSTATE_BASE64' | sed -e 's/^null$$//' | base64 -D > terraform/terraform.tfstate

.PHONY: codefresh-remove-tfstate
codefresh-remove-tfstate:
	@codefresh delete context eks-install
