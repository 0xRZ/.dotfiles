
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


###############
### ohmyzsh ###
###############

# oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export ZSH_CUSTOM="$HOME/.custom_oh-my-zsh"

# name of the theme
ZSH_THEME="powerlevel10k/powerlevel10k"
ENABLE_CORRECTION="true"
DISABLE_MAGIC_FUNCTIONS="true"
# COMPLETION_WAITING_DOTS="true"
# DISABLE_UNTRACKED_FILES_DIRTY="true"
# auto-update
zstyle ':omz:update' mode disabled

plugins=(
				copyfile
				encode64
				extract
				genpass
				autojump
				docker
				git
				gitignore
				vagrant
				npm
				systemd
				suse
				ag
				ripgrep
				cargo
				common-aliases
				copybuffer
				jsontools

				# zsh-vi-mode
				fzf-tab
				fzf
				zsh-autosuggestions
				fast-syntax-highlighting
				# zsh-syntax-highlighting
				history-substring-search
)

# plugins/copyfile
alias cpf='copyfile'

# Aloxaf/fzf-tab
zstyle ':fzf-tab:*' fzf-flags --color=bw

# jeffreytse/zsh-vi-mode
# ZVM_VI_ESCAPE_BINDKEY=kj
# ZVM_KEYTIMEOUT=0.1
# ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT
# ZVM_CURSOR_STYLE_ENABLED=false
# function zvm_after_lazy_keybindings() {
# 	zvm_bindkey vicmd 'H' beginning-of-line
# 	zvm_bindkey vicmd 'L' end-of-line
# 	zvm_bindkey visual 'V' zvm_vi_edit_command_line
# 	zvm_bindkey vicmd 'V' zvm_vi_edit_command_line 
# 	zvm_bindkey visual 'v' zvm_exit_visual_mode
# 	zvm_bindkey vicmd 'n' vi-repeat-find
# 	zvm_bindkey vicmd 'N' vi-rev-repeat-find
# }
# rebind
# function zvm_after_init() {
# 	bindkey '^[[A' history-substring-search-up
# 	bindkey '^[[B' history-substring-search-down
# 	zvm_bindkey vicmd '^[[A' history-substring-search-up   
# 	zvm_bindkey vicmd '^[[B' history-substring-search-down 
# 	source $ZSH_CUSTOM/plugins/fzf-tab/fzf-tab.zsh
# }

# zsh-users/zsh-autosuggestions
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=188,bold,underline"
bindkey '^ ' autosuggest-accept
bindkey '^b' autosuggest-toggle

# zsh-users/zsh-syntax-highlighting
# ZSH_HIGHLIGHT_MAXLENGTH=512
# ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets cursor root)

source $ZSH/oh-my-zsh.sh

# zsh-users/zsh-autosuggestions
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=('backward-char' 'beginning-of-line')


##########################
### User configuration ###
##########################

# zsh configuration
# do not highlight pasted text
zle_highlight=('paste:none')
# show hidden files in completion
setopt globdots
# treat symbols as part of a word
WORDCHARS='*?_-.[]~=\/&;!#$%^(){}<>|'

# widgets 
function expand-alias() {
	zle _expand_alias
	zle self-insert
}
zle -N expand-alias

# bindings
bindkey " " expand-alias
bindkey "^]" magic-space
bindkey -M isearch " " magic-space
bindkey "^t" edit-command-line

# functions
function fzf_get_alias() {
	declare -a res
	command_alias=("${(@f)$(print -rl ${(k)aliases})}")
	command_full=("${(@f)$(print -rl ${aliases})}")
	for ((i = 1; i <= $#command_alias; i++))
			res[i]=$(echo $command_alias[i] : $command_full[i])
	sel=$(printf '%s\n' "${res[@]}" | fzf-tmux | awk '{print $1;}')
	echo $sel
}
	

# aliases
alias tssh='TERM=xterm-256color ssh'
alias a='print -z $(fzf_get_alias)'
alias v='$EDITOR'
alias vt='v -c "set buftype=nofile" -'
alias hl='history | tail'
alias nf='n -P f'
alias ts='tmux new-session -s'
alias ta='tmux attach-session -t'
alias tad='tmux attach-session -d -t'
alias tkss='tmux kill-session -t'
alias tksv='tmux kill-server'
alias tl='tmux list-sessions'
alias gcl='git clone'
alias gclr='git clone --recurse-submodules --jobs $(nproc)'
alias gla='git log --graph --decorate --author=""'
alias ddr='dd if=/dev/urandom bs=4K count=1 | e64 > output.dat'
alias vdss='rm $HOME/.local/share/nvim/sessions/*.vim'
alias vlsw='ls $HOME/.local/share/nvim/swap/*.swp'
alias vdsw='rm -f $HOME/.local/share/nvim/swap/*.swp'
alias rd='\rm -r -f'
alias psg='ps -wwo "pid,wchan,cmd" -p $(pgrep nvim)'
alias k='kill -9 '
alias tclr='trash-empty'
alias "src"='omz reload'


# cat > output.dat << EOF
# 
# EOF


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
