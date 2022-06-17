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
}
zle -N my_widget_prepend-sudo

# edit in $EDITOR
autoload -U edit-command-line
zle -N edit-command-line


#################
#### mappings ###
#################

bindkey -M viins " " my_widget_globalias
bindkey -M viins "^ " magic-space
bindkey -M viins "^T" edit-command-line

function my_init_normal_mode_mappings() {
	bindkey -M vicmd s my_widget_prepend-sudo
	bindkey -M vicmd "^T" edit-command-line
}
my_init_normal_mode_mappings

bindkey -M isearch " " magic-space
