function check_prog() {
    if ! hash "$1" > /dev/null 2>&1; then
        echo "Command not found: $1. Aborting..."
        exit 1
    fi
}

function install_remote() {
    set -x
	stow --target "$HOME"               gdb
	stow --target "$HOME"               nvim
	stow --target "$HOME"               tmux
	stow --target "$HOME"               zsh
    set +x
}

function install_desktop() {
	set -x
	stow --target "$HOME"               bin
	stow --target "$HOME"               fonts
	stow --target "$HOME"               alacritty
	stow --target "$HOME"               i3
	make -C ./i3/.i3blocks
	stow --target "$HOME"               picom
	stow --target "$HOME"               redshift
	stow --target "$HOME"               rofi
	install_remote
	set +x
}

usage="$(basename "$0") [ -r | --remote ] | [ -d | --desktop ] -- install dotfiles

where:
    --remote 	only install dotfiles for programms that are available remotely through terminal interface
    --desktop   install dotfiles fully fledged 

"

CLI=0
DESK=0

while (( "$#" )); do
  case "$1" in
    -r|--remote)
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
    -*|--*=)
      echo "Error: Unsupported flag $1" >&2
      exit 1
      ;;
  esac
done

check_prog stow make gcc
mkdir -p "$HOME/.config"

if [[ $DESK -ne 0 ]]
then
	install_desktop	
elif [[ $CLI -ne 0 ]]
then
	install_remote
else
	echo "Error: specify --remote or --desktop flags $1" >&2
	exit 1
fi
