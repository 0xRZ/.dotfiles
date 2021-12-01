#!/bin/bash

term_configs=(bin nvim tmux zsh nnn)
desktop_configs=("${term_configs[@]}" fonts alacritty i3 picom redshift rofi neomutt)

function check_prog() {
    if ! hash "$1" > /dev/null 2>&1; then
        echo "Command not found: $1. Aborting..."
        exit 1
    fi
}

function check_root() {
	if [ "$EUID" -ne 0 ]
		then echo "run as root"
		exit
	fi
}

function install_term() {
	if [ -z "$(ls -A ~/.config/nnn/plugins)" ]; then
		curl -Ls https://raw.githubusercontent.com/jarun/nnn/master/plugins/getplugs | sh
	else
		echo "nnn plugins already installed"
	fi
	for e in "${term_configs[@]}"; do
		stow --verbose=2 --target "$HOME" "$e"
	done
	./tmux/.config/tmux/plugins/tpm/bin/install_plugins
}

function install_desktop() {
	make -C ./i3/.i3blocks
	for e in "${desktop_configs[@]}"; do
		stow --verbose=2 --target "$HOME" "$e"
	done
}

function check_health() {
	printf "Lines of colors should be continous:\n"
	curl -s https://raw.githubusercontent.com/JohnMorales/dotfiles/master/colors/24-bit-color.sh | bash
}

function clear() {
	for e in "${desktop_configs[@]}"; do
		stow --verbose=2 -D --target "$HOME" "$e"
	done
}

function configure() {
	check_root
	set -x
	check_prog update-alternatives chsh
	chsh -s "$(which zsh)"
	update-alternatives --install /usr/bin/vim vim /usr/local/bin/nvim 200
	set +x
}

function update() {
	set -x
	git submodule update --remote --recursive --jobs "$(nproc)"
	./tmux/.config/tmux/plugins/tpm/bin/update_plugins all
	set +x
}

usage="
$(basename "$0") TYPE [OPTION]

script to install dotfiles

TYPE:
	--t |-term		
		only install dotfiles for programs that are available through terminal interface;
			fetches plugins for an nnn file manager;
			installs plugins for Tmux's Plugin Manager TPM

	--d | -desktop	
		install dotfiles fully fledged;
			compiles c programs for an i3blocks status bar

OPTION:
	--c | -configure
		configure default programs for persistent sessions

	 -u | --update
		update tmux plugins, git submodules

	 -l | --clear
		clean environment from config files

	--checkhealth
		check whether everything set up right
"

CLI=0
DESK=0
while (( $# )); do
  case "$1" in
    -t|--term)
    	CLI=1
    	shift
    	;;
    -d|--desktop)
    	DESK=1
    	shift
    	;;
    -h|--help)
    	echo "$usage"
    	exit
    	;;
    -u|--update)
    	update
    	exit
    	;;
    -c|--configure)
    	configure
    	exit
    	;;
    --checkhealth)
    	check_health
    	exit
    	;;
    -l|--clear)
    	clear
    	exit
    	;;
    -*)
    	echo "Error: Unsupported flag $1" >&2
    	exit 1
    	;;
  esac
done

check_prog stow make gcc curl

if [[ $DESK -ne 0 ]]
then
	install_desktop
elif [[ $CLI -ne 0 ]]
then
	install_term
else
	echo "Error: specify --term or --desktop flags" >&2
	exit 1
fi
