#!/bin/bash

function check_prog() {
	for prg in "$@"
	do
		if ! hash "$prg" > /dev/null 2>&1; then
			echo "Command not found: $prg. Aborting..."
			exit 1
		fi
	done
}

term_configs=(bin nvim tmux zsh nnn linters btop git)
desktop_configs=(fonts alacritty i3 picom redshift rofi)
declare -A fonts=( \
["JetBrains Mono NL Regular Nerd Font Complete.ttf"]="https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/JetBrainsMono/NoLigatures/Regular/complete/JetBrains%20Mono%20NL%20Regular%20Nerd%20Font%20Complete.ttf?raw=true" \
["JetBrains Mono NL Bold Nerd Font Complete.ttf"]="https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/JetBrainsMono/NoLigatures/Bold/complete/JetBrains%20Mono%20NL%20Bold%20Nerd%20Font%20Complete.ttf?raw=true" \
["JetBrains Mono NL Bold Italic Nerd Font Complete.ttf"]="https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/JetBrainsMono/NoLigatures/BoldItalic/complete/JetBrains%20Mono%20NL%20Bold%20Italic%20Nerd%20Font%20Complete.ttf?raw=true" \
["JetBrains Mono NL Italic Nerd Font Complete.ttf"]="https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/JetBrainsMono/NoLigatures/Italic/complete/JetBrains%20Mono%20NL%20Italic%20Nerd%20Font%20Complete.ttf?raw=true" \
["JetBrains Mono NL Regular Nerd Font Complete Mono.ttf"]="https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/JetBrainsMono/NoLigatures/Regular/complete/JetBrains%20Mono%20NL%20Regular%20Nerd%20Font%20Complete%20Mono.ttf?raw=true" \
["JetBrains Mono NL Bold Nerd Font Complete Mono.ttf"]="https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/JetBrainsMono/NoLigatures/Bold/complete/JetBrains%20Mono%20NL%20Bold%20Nerd%20Font%20Complete%20Mono.ttf?raw=true" \
["JetBrains Mono NL Bold Italic Nerd Font Complete Mono.ttf"]="https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/JetBrainsMono/NoLigatures/BoldItalic/complete/JetBrains%20Mono%20NL%20Bold%20Italic%20Nerd%20Font%20Complete%20Mono.ttf?raw=true" \
["JetBrains Mono NL Italic Nerd Font Complete Mono.ttf"]="https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/JetBrainsMono/NoLigatures/Italic/complete/JetBrains%20Mono%20NL%20Italic%20Nerd%20Font%20Complete%20Mono.ttf?raw=true" \
)

function install_term() {
	curl -Ls https://raw.githubusercontent.com/jarun/nnn/master/plugins/getplugs | sh
	for e in "${term_configs[@]}"; do
		stow --verbose=2 --target "$HOME" "$e"
	done
	# tmux plugin manager
	./tmux/.config/tmux/plugins/tpm/bin/install_plugins
}

function install_desktop() {
	pushd .
	cd fonts/.local/share/fonts || exit
	for name in "${!fonts[@]}"
	do
		if ! [ -f "$name" ] ; then
			echo "Downloading \"$name\" font..."
			curl -L "${fonts[$name]}" -o "$name"
		fi
	done
	popd || exit
	make -C ./i3/.i3blocks
	for e in "${desktop_configs[@]}"; do
		stow --verbose=2 --target "$HOME" "$e"
	done
}

function update() {
	local -a submodules_paths
	local is_init=true
	cd "$(dirname "$0")" || { echo "cd failure" >&2; exit 1; }
	IFS=$'\n' read -r -d '' -a submodules_paths < <( git config --file .gitmodules --path --get-regexp 'submodule.*.path$' | cut -d " " -f 2 )
	for i in "${submodules_paths[@]}"
	do
		if ! ls "$i"/.git >/dev/null 2>&1 ; then
			echo >&2 "$i module not initialized."
			is_init=false
		fi
	done
	# INFO: --checkout = checks out superproject's submodule commit always, --remote checks out latest submodule's branch commit
	if [ "$is_init" = true ]; then
		git submodule update --remote --jobs "$(nproc)" --depth 1
		./tmux/.config/tmux/plugins/tpm/bin/update_plugins all
		zsh -i -c "zinit update"
	else
		echo "Initializing repo submodules..."
		git submodule update --checkout --init --jobs "$(nproc)" --depth 1
	fi
}

function clear() {
	for e in "${desktop_configs[@]}"; do
		stow --verbose=2 -D --target "$HOME" "$e"
	done
}

function check_health() {
	printf "Lines of colors should be continous:\n"
	curl -s https://raw.githubusercontent.com/JohnMorales/dotfiles/master/colors/24-bit-color.sh | bash
}

usage="
$(basename "$0") [TYPE || OPTION]

script to install dotfiles

TYPE:
	-t | --term
		only install dotfiles for programs that are available through terminal interface

	-d | --desktop
		install dotfiles fully fledged
			do everything as with --term
			downloads missing nerd fonts
			compiles c blocklets for an i3blocks status bar

OPTION:
	-u | --update
		update:
			git submodules
			tmux plugins
			zsh plugins
		or initialize git submodules if its not initialized already

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
	CLI=1
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

if [[ $CLI -eq 0 && $DESK -eq 0 ]]
then
	echo "Error: specify --term or --desktop flags" >&2
	exit 1
fi

check_prog stow make gcc curl

if [[ $CLI -ne 0 ]]
then
	install_term
fi
if [[ $DESK -ne 0 ]]
then
	install_desktop
fi
