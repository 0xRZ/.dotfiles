################
#### widgets ###
################

function my_widget_globalias() {
	zle _expand_alias
	zle self-insert
}
zle -N my_widget_globalias

function my_widget_prepend-sudo {
	if [[ $BUFFER != "sudo "* ]]; then
		BUFFER="sudo $BUFFER"; CURSOR+=5
	fi
	zvm_enter_insert_mode
}
zle -N my_widget_prepend-sudo

function my_widget_prepend-man {
	if [[ $BUFFER != "man "* ]]; then
		BUFFER="man $BUFFER"; CURSOR+=4
	fi
	zvm_enter_insert_mode
}
zle -N my_widget_prepend-man

# edit in $EDITOR
autoload -U edit-command-line
zle -N edit-command-line


#################
#### mappings ###
#################

function my_init_mappings() {
	bindkey "^T" edit-command-line
	bindkey '^R' fzf-history-widget

	bindkey -M viins " " my_widget_globalias
	bindkey -M viins "^ " magic-space
	bindkey -M viins "^k" history-search-backward

	bindkey -M vicmd s my_widget_prepend-sudo
	bindkey -M vicmd m my_widget_prepend-man

	bindkey -M isearch " " magic-space
}
my_init_mappings
