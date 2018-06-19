.PHONY: setup
setup:
	@./scripts/setup.sh

.PHONY: teardown
teardown:
	@./scripts/teardown.sh

.PHONY: codefresh-save-tfstate
codefresh-save-tfstate:
	@./scripts/codefresh-save-tfstate.sh

.PHONY: codefresh-load-tfstate
codefresh-load-tfstate:
	@./scripts/codefresh-load-tfstate.sh

.PHONY: codefresh-remove-tfstate
codefresh-remove-tfstate:
	@./scripts/codefresh-remove-tfstate.sh

.PHONY: codefresh-add-cluster
codefresh-add-cluster:
	@./scripts/codefresh-add-cluster.sh

.PHONY: clean
clean:
	@git status --ignored --short | grep '^!! ' | sed 's/!! //' | xargs rm -rf
