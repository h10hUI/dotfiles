.PHONY: all
all: init deploy brew other npms defaults

init:
	xcode-select --install > /dev/null 2>&1 ## xcode インストール
	@sh ./brew_install.sh ## brew インストール

deploy:
	@sh ./deploy.sh

defaults:
	@sh ./defaults.sh

brew: init deploy ## init, deploy に依存
	@brew bundle --global

npms: brew # brew に依存
	@brew install node
	@npm install -g git-cz http-server mermaid-cli npm-check-updates typesync ui-flow yarn n
	@n lts
	@brew uninstall node
	@brew bundle dump --global -f

other: deploy ## deploy に依存
	echo "other"
