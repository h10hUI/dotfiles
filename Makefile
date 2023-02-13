SHELL := /bin/bash
.SHELLFLAGS := -eu

.PHONY: all
all: init brew deploy other defaults

init:
	xcode-select --install > /dev/null 2>&1 ## xcode インストール
	@sh ./brew_install.sh ## brew インストール

deploy:
	sh ./deploy.sh

defaults:
	sh ./defaults.sh

brew: init ## init に依存
	echo "brew"

other: deploy ## deploy に依存
	echo "other"
