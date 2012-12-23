#!/usr/bin/env zsh

echo "Checking for SSH key, generating one if it doesn't exist ..."
if [ ! -f ~/.ssh/id_rsa.pub ]
then
	ssh-keygen -t rsa -C "_@freeaddr.info"
	echo "Paste the following public key to Github"
	echo "https://github.com/settings/ssh"
	echo "/**************************************"
	cat ~/.ssh/id_rsa.pub
	echo "**************************************/"
	read -n1 -r -p "Press any key to continue..." key
fi

if [ ! -d $HOME/.zprezto ]
then
	echo "Setting up zsh"
	git clone --recursive git@github.com:eataix/prezto.git "$HOME/.zprezto"
	$HOME/.zprezto/installer.sh
fi

echo "Making directories"
[ -d "$HOME/bin" ] || mkdir $HOME/bin
[ -d "$HOME/code" ] || mkdir $HOME/code
[ -d "$HOME/utils" ] || mkdir $HOME/utils

if [ ! -e $HOME/.tmux.conf ]
then
	git clone git@github.com:eataix/tmux-powerline.git $HOME/utils/tmux-powerline
	export INSTALL_DIR=$HOME/utils/tmux-powerline && \
		$HOME/utils/tmux-powerline/installer.sh
	git clone git@github.com:seebi/tmux-colors-solarized.git $HOME/utils/tmux-colors-solarized
	echo "source $HOME/utils/tmux-colors-solarized/tmuxcolors-256.conf" >> ${HOME}/.tmux.conf
fi

if [ ! -e $HOME/.vimrc ]
then
	git clone git@github.com:eataix/vim-configs.git $HOME/.vim
	$HOME/.vim/installer.sh
fi

