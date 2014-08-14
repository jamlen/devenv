#!/usr/bin/env bash

if [ $# -lt 1 ] ; then
	echo "You must specify at least 1 argument."
	exit 1
fi

case $(id -u) in
	0) 
		sudo -u vagrant -i $0 "$@" # script calling itself as the vagrant user
		;;
	*) 
		while getopts ":n:e:r:p:" opt; do
			case $opt in
				n) git_name="$OPTARG"
					;;
				e) git_email="$OPTARG"
					;;
				r) registry="$OPTARG"
					;;
				p) proxy="$OPTARG"
					;;
				\?) echo "Invalid option -$OPTARG" >&2
					;;
			esac
		done

		ln -s -f /vagrant/home/.vimrc /home/$USER/.vimrc
		ln -s -f /vagrant/home/.gemrc /home/$USER/.gemrc
		ln -s -f /vagrant/home/.tmux.conf /home/$USER/.tmux.conf

		echo "Setting up Git config"
		config="/home/$USER/.gitconfig"
		if [ ! -f "$config" ]; then
			wget -q -nc https://raw.githubusercontent.com/durdn/cfg/master/.gitconfig -O "$config"
			if [ ! -z "$git_name" ]; then
				git config --global user.name "$git_name"
				git config --global user.email "$git_email"
			fi
		fi

		mkdir -p /home/$USER/.vim/

		echo "Creating Symlinks"
		chown -R $USER:$USER /home/$USER/.nvm/
		chown -R $USER:$USER /home/$USER/.vim/
		chown $USER:$USER /home/$USER/.vimrc

		if ! hash nodemon 2>/dev/null; then
			echo "Installing node modules"
			if [ ! -z "$registry" ]; then
				echo "Setting npm registry: $registry"
				npm config --global set registry $registry
			fi
			if [ ! -z "$proxy" ]; then
				echo "Setting npm proxy: $proxy"
				npm config --global set proxy $proxy
				npm config --global set https-proxy $proxy
			fi
			npm install --loglevel error -g nodemon mocha grunt-cli js-beautify grunt-init
		fi
		if [ ! -d /home/$USER/.grunt-init/ ]; then
			echo "Installing grunt-init-node"
			git clone https://github.com/gruntjs/grunt-init-node.git /home/$USER/.grunt-init/node
			chown -R $USER:$USER /home/$USER/.grunt-init/
		fi

		if ! hash tmux-mem-cpu-load 2>/dev/null; then
			echo "Installing tmux cpu-mem"
			git clone https://github.com/thewtex/tmux-mem-cpu-load.git /tmp/tmux
			cd /tmp/tmux
			cmake .
			make
			sudo make install
		fi
		;;
esac


echo "Done!"
echo "Your vagrant development environment is ready to use"
