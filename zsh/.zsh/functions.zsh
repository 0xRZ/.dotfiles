function fzf_get_alias() {
	declare -a res
	# collect array from alias command by newlines
	aliases_key=("${(@f)$(alias -r | cut -d'=' -f1)}")
	aliases_val=("${(@f)$(alias -r | cut -d'=' -f2-)}")
	aliases_key+=("${(@f)$(alias -g | cut -d'=' -f1)}")
	aliases_val+=("${(@f)$(alias -g | cut -d'=' -f2-)}")
	for ((i = 1; i <= $#aliases_key; i++))
		res[i]=$(printf '%s : %s\n' $aliases_key[i] $aliases_val[i])
	sel=$(printf '%s\n' "${res[@]}" | fzf-tmux | awk '{print $1;}')
	echo $sel
}

function curl-cert() {
	openssl s_client -showcerts -connect "${1}":443 -servername ${1}
}

function mans() {
    man -k . \
    | fzf -n1,2 --preview "echo {} \
    | cut -d' ' -f1 \
    | sed 's# (#.#' \
    | sed 's#)##' \
    | xargs -I% man %" --bind "enter:execute: \
      (echo {} \
      | cut -d' ' -f1 \
      | sed 's# (#.#' \
      | sed 's#)##' \
      | xargs -I% man % \
      | less -R)"

}

function bl() {
	url=$(buku -p -f4 | fzf -m --reverse --preview "buku -p {1}" --preview-window=wrap | cut -f2)
	if [ -n "$url" ]; then
		echo "$url" | xargs firefox
	fi
}

function my_print_quotes() {
	while [[ true ]]; do
		quote
	done
}

function my_create_edit_tmp() {
	local TMP=$(mktemp)
	$EDITOR ${TMP}
	echo ${TMP} | xclip -i -selection clipboard
	CLIPBOARD_TEXT=$(xclip -o -selection clipboard)
	echo "$CLIPBOARD_TEXT copied to clipboard"
}

function my_list_completions() {
	for command completion in ${(kv)_comps:#-*(-|-,*)}
	do
		printf "%s %s\n" $command $completion
	done | sort | fzf-tmux | cut -d" " -f2 | xclip -i -selection clipboard
	CLIPBOARD_TEXT=$(xclip -o -selection clipboard)
	echo "$CLIPBOARD_TEXT copied to clipboard"
}

function my_list_widgets() {
	zle -al | fzf-tmux | xclip -i -selection clipboard
	CLIPBOARD_TEXT=$(xclip -o -selection clipboard)
	echo "$CLIPBOARD_TEXT copied to clipboard"
}

function my_add_git_remote() {
	git remote add $1 $2
	git fetch $1
}

function my_git_log_grep() {
	git log --all --grep="$1"
}

function my_create_script() {
	if [[ -z "$1" ]]; then
		echo "Enter script name. Aborting..."
		return 1
	fi
	echo -e '#!/bin/bash\n\n' > "$1"
	$EDITOR + "$1"
	chmod +x $1
}

function my_editor_open ()
{
	if echo $1 | grep -E ":[[:digit:]]+$"; then
		local filename=$(echo $1 | cut -d':' -f1)
		local line=$(echo $1 | cut -d':' -f2)
		$EDITOR +${line} ${filename}
	else
		if [ ! -f $1 ]; then
			local dir=$(dirname $1)
			mkdir -p ${dir}
			echo -e '\n' > $1
		fi
		$EDITOR $1
	fi
}

function my_ripgrep_fzf() {
	INITIAL_QUERY=""; \
	RG_PREFIX="rg --column --line-number --hidden --no-ignore --no-heading --color=always --smart-case "; \
	FZF_DEFAULT_COMMAND="$RG_PREFIX '$INITIAL_QUERY'"; \
	  fzf --bind "change:reload:$RG_PREFIX {q} || true" \
      --ansi --color=light --disabled --query "$INITIAL_QUERY" \
      --height=50% --layout=reverse
}

function my_fd_big() {
	czkawka_cli big -d ${PWD}
}

function my_fd_dup() {
	czkawka_cli dup -d ${PWD}
}

function my_fd_all() {
	czkawka_cli broken -d ${PWD}
	czkawka_cli empty-files -d ${PWD}
	czkawka_cli empty-folders -d ${PWD}
	czkawka_cli symlinks -d ${PWD}
}

function psf() {
	ps -wwo "pid,wchan,cmd" -p $(pgrep $1)
}
compdef _pgrep psf

function my_get_cheats() {
	CHTSH_QUERY_OPTIONS="style=vs" cht.sh $* | xclip -i -selection clipboard
	CLIPBOARD_TEXT=$(xclip -o -selection clipboard)
	UNESCAPED_CLIPBOARD_TEXT=$( sed "s,\x1B\[[0-9;]*[a-zA-Z],,g" <(xclip -o -selection clipboard) )
	echo $UNESCAPED_CLIPBOARD_TEXT | xclip -i -selection clipboard
	echo $CLIPBOARD_TEXT | less
	echo $@ cheatsheet copied to clipboard
}
compdef _cht my_get_cheats

function my_create_gitignore() {
	gi $1 >> .gitignore
}
compdef _gitignoreio my_create_gitignore

function my_modify_taskwarrior_task() {
	task $1 modify "${@:2}"
}
compdef _task my_modify_taskwarrior_task

function my_eval_var() {
	echo "cmd: ${(P)1}"
	if read -q "?Press Y/y to continue: "; then
		echo
		eval "${(P)1}"
    else
        echo
        echo "'$choice' not 'Y' or 'y'. Exiting..."
    fi
}
compdef _vars my_eval_var
