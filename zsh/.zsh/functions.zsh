function fzf_get_alias() {
	declare -a res
	command_alias=("${(@f)$(print -rl ${(k)aliases})}")
	command_full=("${(@f)$(print -rl ${aliases})}")
	for ((i = 1; i <= $#command_alias; i++))
			res[i]=$(echo $command_alias[i] : $command_full[i])
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
	echo ${TMP}
}

function my_list_completions() {
	for command completion in ${(kv)_comps:#-*(-|-,*)}
	do
		printf "%-32s %s\n" $command $completion
	done | sort | less
}

function psf() {
	ps -wwo "pid,wchan,cmd" -p $(pgrep $1)
}
compdef _pgrep psf

function my_get_cheats() {
	CHTSH_QUERY_OPTIONS="style=vs" cht.sh $* | less;
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
