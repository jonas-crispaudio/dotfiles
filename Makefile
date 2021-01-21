DOTFILES_DIR := $(dir $(realpath $(firstword $(MAKEFILE_LIST))))
HOME_DIR := /home/jonas

core-linux:
	apt-get update -y
	apt-get upgrade -y
	#apt-get dist-upgrade -f -y

system-setup:
	apt-get install -y git
	apt-get install -y vim
	apt-get install -y curl
	apt-get install -y tmux
	apt-get install -y ripgrep

vim-plugins:
	mkdir -p $(HOME_DIR)/.vim/pack/vendor/start/
	mkdir -p $(HOME_DIR)/.vim/plugin/
	mkdir -p $(HOME_DIR)/.vim/after/syntax/
	git clone https://github.com/junegunn/fzf.git $(HOME_DIR)/.vim/pack/vendor/start/fzf/
	$(HOME_DIR)/.vim/pack/vendor/start/fzf/install --all
	git clone https://github.com/bfrg/vim-cpp-modern $(HOME_DIR)/.vim/plugin/vim-cpp-modern/
	git clone https://github.com/morhetz/gruvbox.git $(HOME_DIR)/.vim/pack/vendor/start/gruvbox/
	git clone https://github.com/junegunn/fzf.vim.git $(HOME_DIR)/.vim/pack/vendor/start/fzf.vim/
	git clone https://github.com/itchyny/vim-gitbranch.git $(HOME_DIR)/.vim/pack/vendor/start/vim-gitbranch/
	git clone https://github.com/itchyny/lightline.vim.git $(HOME_DIR)/.vim/pack/vendor/start/lightline.vim/
	git clone https://github.com/preservim/nerdcommenter.git $(HOME_DIR)/.vim/pack/vendor/start/nerdcommenter/
	git clone https://github.com/christoomey/vim-tmux-navigator.git $(HOME_DIR)/.vim/pack/vendor/start/vim-tmux-navigator/
	curl -s https://www.vim.org/scripts/download_script.php?src_id=7218 > $(HOME_DIR)/.vim/plugin/a.vim
	cp $(HOME_DIR)/.vim/plugin/vim-cpp-modern/after/syntax/c.vim $(HOME_DIR)/.vim/after/syntax/
	cp $(HOME_DIR)/.vim/plugin/vim-cpp-modern/after/syntax/cpp.vim $(HOME_DIR)/.vim/after/syntax/

create-symlinks:
	if [ -f $(HOME_DIR)/.vimrc ]; then mv $(HOME_DIR)/.vimrc $(HOME_DIR)/.vimrc.backup; fi;
	if [ -f $(HOME_DIR)/.bashrc ]; then mv $(HOME_DIR)/.bashrc $(HOME_DIR)/.bashrc.backup; fi;
	if [ -f $(HOME_DIR)/.tmux.conf ]; then mv $(HOME_DIR)/.tmux.conf $(HOME_DIR)/.tmux.conf.backup; fi;
	ln -s $(DOTFILES_DIR).vimrc $(HOME_DIR)/.vimrc
	ln -s $(DOTFILES_DIR).bashrc $(HOME_DIR)/.bashrc
	ln -s $(DOTFILES_DIR).tmux.conf $(HOME_DIR)/.tmux.conf

setup:
	make core-linux
	make system-setup
	make vim-plugins
	make create-symlinks

restore-dotfiles:
	if [ -f $(HOME_DIR)/.vimrc.backup ]; then mv $(HOME_DIR)/.vimrc.backup $(HOME_DIR)/.vimrc; fi;
	if [ -f $(HOME_DIR)/.bashrc.backup ]; then mv $(HOME_DIR)/.bashrc.backup $(HOME_DIR)/.bashrc; fi;
	if [ -f $(HOME_DIR)/.tmux.conf.backup ]; then mv $(HOME_DIR)/.tmux.conf.backup $(HOME_DIR)/.tmux.conf; fi;

restore:
	make restore-dotfiles
	
vim-plugins-update:
	mkdir -p $(HOME_DIR)/.vim/pack/vendor/start/
	mkdir -p $(HOME_DIR)/.vim/plugin/
	mkdir -p $(HOME_DIR)/.vim/after/syntax/
	if [ -d $(HOME_DIR)/.vim/pack/vendor/start/fzf/ ]; then \
		cd $(HOME_DIR)/.vim/pack/vendor/start/fzf/; \
		git fetch origin; \
		$(HOME_DIR)/.vim/pack/vendor/start/fzf/install --all; \
		cd -; \
	else \
		git clone https://github.com/junegunn/fzf.git $(HOME_DIR)/.vim/pack/vendor/start/fzf/; \
		$(HOME_DIR)/.vim/pack/vendor/start/fzf/install --all; \
	fi
	if [ -d $(HOME_DIR)/.vim/plugin/vim-cpp-modern/ ]; then \
		cd $(HOME_DIR)/.vim/plugin/vim-cpp-modern/; \
		git fetch origin; \
		cd -; \
	else \
		git clone https://github.com/bfrg/vim-cpp-modern $(HOME_DIR)/.vim/plugin/vim-cpp-modern/; \
	fi
	if [ -d $(HOME_DIR)/.vim/pack/vendor/start/gruvbox/ ]; then \
		cd $(HOME_DIR)/.vim/pack/vendor/start/gruvbox/; \
		git fetch origin; \
		cd -; \
	else \
		git clone https://github.com/morhetz/gruvbox.git $(HOME_DIR)/.vim/pack/vendor/start/gruvbox/; \
	fi
	if [ -d $(HOME_DIR)/.vim/pack/vendor/start/fzf.vim/ ]; then \
		cd $(HOME_DIR)/.vim/pack/vendor/start/fzf.vim/; \
		git fetch origin; \
		cd -; \
	else \
		git clone https://github.com/junegunn/fzf.vim.git $(HOME_DIR)/.vim/pack/vendor/start/fzf.vim/; \
	fi
	if [ -d $(HOME_DIR)/.vim/pack/vendor/start/vim-gitbranch/ ]; then \
		cd $(HOME_DIR)/.vim/pack/vendor/start/vim-gitbranch/; \
		git fetch origin; \
		cd -; \
	else \
		git clone https://github.com/itchyny/vim-gitbranch.git $(HOME_DIR)/.vim/pack/vendor/start/vim-gitbranch/; \
	fi
	if [ -d $(HOME_DIR)/.vim/pack/vendor/start/lightline.vim/ ]; then \
		cd $(HOME_DIR)/.vim/pack/vendor/start/lightline.vim/; \
		git fetch origin; \
		cd -; \
	else \
		git clone https://github.com/itchyny/lightline.vim.git $(HOME_DIR)/.vim/pack/vendor/start/lightline.vim/; \
	fi
	if [ -d $(HOME_DIR)/.vim/pack/vendor/start/nerdcommenter/ ]; then \
		cd $(HOME_DIR)/.vim/pack/vendor/start/nerdcommenter/; \
		git fetch origin; \
		cd -; \
	else \
		git clone https://github.com/preservim/nerdcommenter.git $(HOME_DIR)/.vim/pack/vendor/start/nerdcommenter/; \
	fi
	if [ -d $(HOME_DIR)/.vim/pack/vendor/start/vim-tmux-navigator/ ]; then \
		cd $(HOME_DIR)/.vim/pack/vendor/start/vim-tmux-navigator/; \
		git fetch origin; \
		cd -; \
	else \
		git clone https://github.com/christoomey/vim-tmux-navigator.git $(HOME_DIR)/.vim/pack/vendor/start/vim-tmux-navigator/; \
	fi
	cp $(HOME_DIR)/.vim/plugin/vim-cpp-modern/after/syntax/c.vim $(HOME_DIR)/.vim/after/syntax/
	cp $(HOME_DIR)/.vim/plugin/vim-cpp-modern/after/syntax/cpp.vim $(HOME_DIR)/.vim/after/syntax/

update:
	make core-linux
	make system-setup
	make vim-plugins-update
