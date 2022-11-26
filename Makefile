.PHONY: all
all: init link defaults brew

init:
	xcode-select --install > /dev/null 2>&1 ## xcode インストール
	@sh ./brew_install.sh ## brew インストール

link:
	echo "link"

defaults:
	echo "default"

brew: init ## init に依存
	echo "brew"
