.PHONY: all
all: init deploy brew other tools defaults

init:
	xcode-select --install > /dev/null 2>&1 ## xcode インストール
	@sh ./brew_install.sh ## brew インストール

deploy:
	@sh ./deploy.sh

defaults:
	@sh ./defaults.sh

brew: init deploy ## init, deploy に依存
	@brew bundle --global

tools: brew # brew に依存
	@brew install node
	@npm install -g git-cz http-server mermaid-cli npm-check-updates typesync ui-flow yarn n
	@n lts
	@brew uninstall node
	@brew install python
	@brew unlink python
	@pip3 install neovim
	@brew bundle dump --global -f

other: deploy ## deploy に依存
	@echo "other"
