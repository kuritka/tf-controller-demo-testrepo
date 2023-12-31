ifneq ($(wildcard ./.env),)
	include .env
	export
endif

tfsec:
	@echo "Running tfsec"
	@brew install tfsec
	# tfsec doesnt support import blocks yet: https://github.com/aquasecurity/tfsec/issues/2070#issuecomment-1669056215
	tfsec --ignore-hcl-errors

tflint:
	@echo "Running tflint"
	@brew install tflint
	tflint -f compact --recursive

tfmt:
	terraform fmt -recursive

check: tfmt tflint tfsec

init:
	terraform init -migrate-state

download-tfstate:
	kubectl get secret tfstate-default-state -ojsonpath='{.data.tfstate}' -n backend --context=k3d-backend | base64 -d | gzip -d > terraform.tfstate
