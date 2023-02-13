.PHONY: all
all: init deploy brew other defaults

init:
	xcode-select --install > /dev/null 2>&1 ## xcode インストール
	@sh ./brew_install.sh ## brew インストール

deploy:
	@sh ./deploy.sh

defaults:
	@sh ./defaults.sh

brew: init deploy ## init, deploy に依存
	@brew bundle --global
	@brew install node
	n lts
	brew uninstall node

other: deploy ## deploy に依存
	echo "other"
