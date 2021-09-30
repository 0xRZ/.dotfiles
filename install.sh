term_configs=(bin gdb nvim tmux zsh nnn)
desktop_configs=("${term_configs[@]}" usr fonts alacritty i3 picom redshift rofi)

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
	set -x
	curl -Ls https://raw.githubusercontent.com/jarun/nnn/master/plugins/getplugs | sh
	for e in ${term_configs[@]}; do
		stow --target "$HOME" $e
	done
	./tmux/.config/tmux/plugins/tpm/bin/install_plugins
	set +x
}

function install_desktop() {
	set -x
	make -C ./i3/.i3blocks
	for e in ${desktop_configs[@]}; do
		stow --target "$HOME" $e
	done
	set +x
}

function clear() {
	set -x
	for e in ${desktop_configs[@]}; do
		stow -D --target "$HOME" $e
	done
	set +x
}

function configure() {
	check_root
	set -x
	check_prog update-alternatives chsh
	chsh -s $(which zsh)
	update-alternatives --install /usr/bin/vim vim /usr/local/bin/nvim 200
	set +x
}

function update() {
	set -x
	git submodule update --remote --recursive --jobs $(nproc)
	./tmux/.config/tmux/plugins/tpm/bin/update_plugins all
	set +x
}

usage="
$(basename "$0") [ -t | --term ] | [ -d | --desktop ] | [ -c | --configure ] | [ -u | --update ] [ -l | --clear ] -- install dotfiles

where:
	--term 			only install dotfiles for programms that are available through terminal interface
	--desktop 		install dotfiles fully fledged
	--configure		configure default programms for persistent sessions
	--update		update tmux plugins, git submodules
	--clear			clean environment from config files
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
    -l|--clear)
      clear
      exit
      ;;
    -*|--*=)
      echo "Error: Unsupported flag $1" >&2
      exit 1
      ;;
  esac
done

check_prog stow make gcc

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
