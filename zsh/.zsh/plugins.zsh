# plugins location: $ZINIT[PLUGINS_DIR]
ZINIT_HOME="$HOME/.zsh/zinit"
source "${ZINIT_HOME}/zinit.zsh"

### ohmyzsh plugins
# https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins
# export ZSH="$HOME/ohmyzsh"
# disable when problems when pasting URLs or pasting anything at all
DISABLE_MAGIC_FUNCTIONS="true"
# disable autoupdates
zstyle ':omz:update' mode disabled
plugins=(
	common-aliases
	copybuffer
	copyfile
	fzf
	genpass
	git
	gitignore
	golang
	jsontools
	magic-enter
	npm
	pip
	python
	rand-quote
	rust
	suse
	systemd
	tmuxinator
	universalarchive
	vagrant
	vscode
)
# source $ZSH/oh-my-zsh.sh
zinit ice depth"1" # git clone depth
zinit light ohmyzsh/ohmyzsh

### show tab-completion items with fzf ###
zinit light Aloxaf/fzf-tab
# show tmux popup to show results
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# a prefix to indicate the color.
zstyle ':fzf-tab:*' prefix ''
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group 'ctrl-h' 'ctrl-l'
# select and execute
zstyle ':fzf-tab:*' fzf-bindings 'ctrl-s:jump'
# color for items without group (e.g. files)
zstyle ':fzf-tab:*' default-color $'\033[38;5;234m'
# light fzf colorscheme
zstyle ':fzf-tab:*' fzf-flags --color=light

### show autosuggestions as-you-type ###
zinit light zsh-users/zsh-autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#cacaca,bold,underline"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

### auto-instert pairs ###
zinit ice wait"1" lucid # loading is done 1 second after prompt (hide Loaded message)
zinit light hlissner/zsh-autopair

### git with fzf ###
FORGIT_NO_ALIASES=true
FORGIT_COPY_CMD='xclip -selection clipboard'
zinit load wfxr/forgit

### highlight shell syntax ###
# fast-theme "base16"
zinit light zdharma-continuum/fast-syntax-highlighting

### theme ###
zinit ice depth"1" # git clone depth
zinit light romkatv/powerlevel10k

### vi-mode ###
ZVM_VI_ESCAPE_BINDKEY=kj
# ZVM_INIT_MODE=sourcing
zinit light jeffreytse/zsh-vi-mode
function my_zvm_after_lazy_keybindings() {
	zvm_bindkey vicmd 'H' beginning-of-line
	zvm_bindkey vicmd 'L' end-of-line
	zvm_bindkey visual 'v' zvm_exit_visual_mode
	zvm_bindkey visual 'x' zvm_vi_delete
}
zvm_after_lazy_keybindings_commands+=(my_zvm_after_lazy_keybindings)
zvm_after_lazy_keybindings_commands+=(my_init_mappings)
function my_zvm_after_init() {
	my_init_mappings
}
zvm_after_init_commands+=(my_zvm_after_init)
