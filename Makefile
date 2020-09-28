DOTFILES_DIR := $(dir $(realpath $(firstword $(MAKEFILE_LIST))))

core-linux:
	apt-get update -y
	apt-get upgrade -y
	apt-get dist-upgrade -f -y

system-setup:
	apt-get install -y git
	apt-get install -y vim
	apt-get install -y curl
	apt-get install -y tmux
	apt-get install -y ripgrep

vim-plugins:
	mkdir -p ~/.vim/pack/vendor/start/
	mkdir -p ~/.vim/plugin/
	mkdir -p ~/.vim/after/syntax/
	git clone https://github.com/junegunn/fzf.git ~/.vim/pack/vendor/start/fzf/
	git clone https://github.com/bfrg/vim-cpp-modern ~/.vim/plugin/vim-cpp-modern/
	git clone https://github.com/morhetz/gruvbox.git ~/.vim/pack/vendor/start/gruvbox/
	git clone https://github.com/junegunn/fzf.vim.git ~/.vim/pack/vendor/start/fzf.vim/
	git clone https://github.com/itchyny/vim-gitbranch.git ~/.vim/pack/vendor/start/vim-gitbranch/
	git clone https://github.com/itchyny/lightline.vim.git ~/.vim/pack/vendor/start/lightline.vim/
	git clone https://github.com/preservim/nerdcommenter.git ~/.vim/pack/vendor/start/nerdcommenter/
	git clone https://github.com/christoomey/vim-tmux-navigator.git ~/.vim/pack/vendor/start/vim-tmux-navigator/
	curl -s https://www.vim.org/scripts/download_script.php?src_id=7218 > ~/.vim/plugin/a.vim
	cp ~/.vim/plugin/vim-cpp-modern/after/syntax/c.vim ~/.vim/after/syntax/
	cp ~/.vim/plugin/vim-cpp-modern/after/syntax/cpp.vim ~/.vim/after/syntax/

create-symlinks:
	if [ -f ~/.vimrc ]; then mv ~/.vimrc ~/.vimrc.backup; fi;
	if [ -f ~/.bashrc ]; then mv ~/.bashrc ~/.bashrc.backup; fi;
	if [ -f ~/.tmux.conf ]; then mv ~/.tmux.conf ~/.tmux.conf.backup; fi;
	ln -s $(DOTFILES_DIR).vimrc ~/.vimrc
	ln -s $(DOTFILES_DIR).bashrc ~/.bashrc
	ln -s $(DOTFILES_DIR).tmux.conf ~/.tmux.conf

setup:
	make core-linux
	make system-setup
	make vim-plugins
	make create-symlinks

restore-dotfiles:
	if [ -f ~/.vimrc.backup ]; then mv ~/.vimrc.backup ~/.vimrc; fi;
	if [ -f ~/.bashrc.backup ]; then mv ~/.bashrc.backup ~/.bashrc; fi;
	if [ -f ~/.tmux.conf.backup ]; then mv ~/.tmux.conf.backup ~/.tmux.conf; fi;

restore:
	make restore-dotfiles
	
vim-plugins-update:
	apt-get install -y git
	apt-get install -y vim
	apt-get install -y curl
	apt-get install -y tmux
	apt-get install -y ripgrep
	mkdir -p ~/.vim/pack/vendor/start/
	mkdir -p ~/.vim/plugin/
	mkdir -p ~/.vim/after/syntax/
	if [ -d ~/.vim/pack/vendor/start/fzf/ ]; then \
		cd ~/.vim/pack/vendor/start/fzf/; \
		git fetch origin; \
		cd -; \
	else \
		git clone https://github.com/junegunn/fzf.git ~/.vim/pack/vendor/start/fzf/; \
	fi
	if [ -d ~/.vim/plugin/vim-cpp-modern/ ]; then \
		cd ~/.vim/plugin/vim-cpp-modern/; \
		git fetch origin; \
		cd -; \
	else \
		git clone https://github.com/bfrg/vim-cpp-modern ~/.vim/plugin/vim-cpp-modern/; \
	fi
	if [ -d ~/.vim/pack/vendor/start/gruvbox/ ]; then \
		cd ~/.vim/pack/vendor/start/gruvbox/; \
		git fetch origin; \
		cd -; \
	else \
		git clone https://github.com/morhetz/gruvbox.git ~/.vim/pack/vendor/start/gruvbox/; \
	fi
	if [ -d ~/.vim/pack/vendor/start/fzf.vim/ ]; then \
		cd ~/.vim/pack/vendor/start/fzf.vim/; \
		git fetch origin; \
		cd -; \
	else \
		git clone https://github.com/junegunn/fzf.vim.git ~/.vim/pack/vendor/start/fzf.vim/; \
	fi
	if [ -d ~/.vim/pack/vendor/start/vim-gitbranch/ ]; then \
		cd ~/.vim/pack/vendor/start/vim-gitbranch/; \
		git fetch origin; \
		cd -; \
	else \
		git clone https://github.com/itchyny/vim-gitbranch.git ~/.vim/pack/vendor/start/vim-gitbranch/; \
	fi
	if [ -d ~/.vim/pack/vendor/start/lightline.vim/ ]; then \
		cd ~/.vim/pack/vendor/start/lightline.vim/; \
		git fetch origin; \
		cd -; \
	else \
		git clone https://github.com/itchyny/lightline.vim.git ~/.vim/pack/vendor/start/lightline.vim/; \
	fi
	if [ -d ~/.vim/pack/vendor/start/nerdcommenter/ ]; then \
		cd ~/.vim/pack/vendor/start/nerdcommenter/; \
		git fetch origin; \
		cd -; \
	else \
		git clone https://github.com/preservim/nerdcommenter.git ~/.vim/pack/vendor/start/nerdcommenter/; \
	fi
	if [ -d ~/.vim/pack/vendor/start/vim-tmux-navigator/ ]; then \
		cd ~/.vim/pack/vendor/start/vim-tmux-navigator/; \
		git fetch origin; \
		cd -; \
	else \
		git clone https://github.com/christoomey/vim-tmux-navigator.git ~/.vim/pack/vendor/start/vim-tmux-navigator/; \
	fi
	cp ~/.vim/plugin/vim-cpp-modern/after/syntax/c.vim ~/.vim/after/syntax/
	cp ~/.vim/plugin/vim-cpp-modern/after/syntax/cpp.vim ~/.vim/after/syntax/

update:
	make core-linux
	make system-setup
	make vim-plugins-update
