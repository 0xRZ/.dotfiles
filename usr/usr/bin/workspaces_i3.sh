#!/bin/sh

usage="$(basename "$0") [-s] [-r] -- save or restore i3 session, defaults to save"

function save_session() {
	i3-resurrect save -w 1 --swallow=class
	i3-resurrect save -w 2
	i3-resurrect save -w 3
}

function restore_session() {
    i3-resurrect restore -w 1 
	i3-msg 'workspace 1; exec firefox'
	i3-resurrect restore -w 2
	i3-resurrect restore -w 3
}

while (( "$#" )); do
  case "$1" in
    -s|--save)
      save_session
      exit
      ;;
    -r|--restore)
      restore_session
      exit
      ;;
    -h|--help)
      echo "$usage"
      exit
      ;;
    -*|--*=) # unsupported flags
      echo "Error: Unsupported flag $1" >&2
      exit 1
      ;;
  esac
done

save_session
