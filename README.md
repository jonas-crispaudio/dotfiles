# Dotfiles

These are my dotfiles for vim, bash and tmux.

It targets Unix systems.

## Package overview

- git
- curl
- tmux
- vim
- ripgrep

## Makefile

Use the [Makefile](./Makefile) to install everything [listed above](#package-overview) and create symlinks:

    apt-get install make
    cd ~/dotfiles
    edit HOME_DIR variable fitting to the user to install (for example: /home/testuser
    sudo make setup

And to update everything the system and the vim plugins:
    
    cd ~/dotfiles
    sudo make update

To restore your old dotfiles:

    cd ~/dotfiles
    sudo make restore
