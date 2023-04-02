NIXPKGS_DIR := $(HOME)/.config/nixpkgs

.PHONY: default install switch uninstall help

default: help

install: install-homebrew ## Install Homebrew and Nix and activate this configuration
	@sh -c "'$(CURDIR)/scripts/install.sh'"

install-homebrew:
	@sh -c "'$(CURDIR)/scripts/install_homebrew.sh'"

switch: ## Activate latest changes
	@sh -c "./result/sw/bin/darwin-rebuild switch --flake ./nix"

uninstall: ## Uninstall Nix
	@sh -c "'$(CURDIR)/scripts/uninstall.sh'"

uninstall-homebrew:
	@sh -c "'$(CURDIR)/scripts/uninstall_homebrew.sh'"

help: ## Display this help screen
	@grep -h -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
