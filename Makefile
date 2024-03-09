# vim: set noexpandtab :
.PHONY: all
all: init deploy brew other tools defaults

init:
	@sh ./brew_install.sh ## brew インストール

deploy:
	@sh ./deploy.sh
	@sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

defaults:
	@sh ./defaults.sh

brew: init deploy ## init, deploy に依存
	@brew bundle --global

tools: brew # brew に依存
	@brew install node
	@npm install -g git-cz http-server mermaid-cli npm-check-updates typesync yarn n
	@sudo n lts
	@brew uninstall node
	@brew install python
	@brew unlink python
	@pip3 install neovim
	@brew bundle dump --global -f

other: brew ## brew に依存
	@mkdir -p ~/.config/karabiner
	@cp -fv karabiner.json ~/.config/karabiner
