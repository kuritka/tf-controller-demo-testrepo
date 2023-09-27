# .tflint.hcl
# Reference: https://github.com/terraform-linters/tflint
# On local to initialize a configuration file for TFLint in your Terraform project: tflint --init
plugin "terraform" {
  enabled = true
  version = "0.4.0"
  source  = "github.com/terraform-linters/tflint-ruleset-terraform"
}