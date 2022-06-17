alias a='print -z $(fzf_get_alias)'
alias k='sudo `which kmon` --color 6f849c --accent-color e35760'
alias m='btop -p 0'
alias b='buku --suggest'
alias v='$EDITOR'
alias K='kill -9 '
alias rd='trash-put'
alias ea='direnv allow .'
alias ng='npm install -g'
alias vg='neovide --multigrid --noidle '
alias nf='n -P f'
alias src='omz reload'
alias ddr='dd if=/dev/urandom bs=4K count=1 | base64 > output.dat'
alias vrs='trash-put $HOME/.local/share/nvim/swap/*.swp'
alias vrS='trash-put $HOME/.local/share/nvim/sessions/*.vim'
alias tssh='TERM=xterm-256color ssh'

alias gcl='git clone'
alias gclr='git clone --recurse-submodules --jobs $(nproc)'
alias gla='git log --graph --decorate --author=""'
alias GI='git_current_user_name; git_current_user_email'
alias gsa='git submodule add -b <branch_to_track_if_any> <url>'
alias gsr='git rm <path-to-submodule>'

alias ts='tmux new-session -s'
alias ta='tmux attach-session -t'
alias tk='tmux kill-session -t'
alias tK='tmux kill-server'
alias tl='tmux list-sessions'
alias Tn='tmuxinator new'
alias Te='tmuxinator edit'
alias Ts='tmuxinator start'
alias Tl='tmuxinator list'
alias Td='tmuxinator delete'
alias TA='task add'
alias TL='task list'
alias TK='task done'
alias TE='my_modify_taskwarrior_task'

alias -g F='| fzf-tmux'
alias -g H='--help | less'

# .zsh/functions.zsh
alias c='my_get_cheats'
alias V='my_create_edit_tmp'
alias gia='my_create_gitignore'

# ohmyzsh_plugins/copyfile
alias cpf='copyfile'
# ohmyzsh_plugins/jsontools
alias -g J='| pp_json'
