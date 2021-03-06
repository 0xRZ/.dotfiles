# environment variables
export PATH=$HOME/bin:$HOME/usr/bin:$HOME/.local/bin:$HOME/.cargo/bin:$HOME/go/bin:${HOME}/npm/bin:$PATH
fpath=(~/.zsh.d/ $fpath)
export XDG_CONFIG_HOME=$HOME/.config
export LANG=en_US.UTF-8
export EDITOR='nvim'
export TERM=alacritty
export COLORTERM=truecolor
export SHELL=/bin/zsh
# n/curses: number of milliseconds to wait after reading an escape character
export ESCDELAY=0
# fuzzy finder
export FZF_DEFAULT_OPTS='-m --bind=ctrl-d:preview-page-down,ctrl-u:preview-page-up,ctrl-s:jump,ctrl-space:toggle,ctrl-a:toggle-all'

# nnn file manager
export NNN_BMS="\
c:$HOME/.config;h:/home;t:$HOME/.local/share/Trash;\
b:$HOME/build;n:$HOME/.local/share/nvim;p:$HOME/.backup;\
a:$HOME/.tmp;d:$HOME/.dotfiles;\
"
NNN_PLUG_BUNDLED='m:bulknew;f:fzcd;t:mimelist;p:preview-tui'
NNN_PLUG_CMDS='s:-!sudoedit $nnn*;g:-!neovide --multigrid --log $nnn*'
NNN_PLUG_YANK='y:nnn_file_path_yank;Y:nnn_file_name_yank;d:nnn_file_dir_yank'
NNN_PLUG_CD='c:nnn_clipboard_file_path_cd'
export NNN_PLUG="$NNN_PLUG_BUNDLED;$NNN_PLUG_CMDS;$NNN_PLUG_YANK;$NNN_PLUG_CD;"
export NNN_TRASH=1
export NNN_OPENER=nnn_nvim_opener
n ()
{
    # Block nesting of nnn in subshells
    if [ -n $NNNLVL ] && [ "${NNNLVL:-0}" -ge 1 ]; then
        echo "nnn is already running"
        return
    fi

    # The default behaviour is to cd on quit (nnn checks if NNN_TMPFILE is set)
    # To cd on quit only on ^G, remove the "export" as in:
    #     NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

	# multiple NNN_FIFO for previewers
	# show hidden files by default
	# CLI only custom opener
	# always use selection
	# sort by time accessed
    nnn -a -H -c -u -T 't' "$@"

    if [ -f "$NNN_TMPFILE" ]; then
            . "$NNN_TMPFILE"
            rm -f "$NNN_TMPFILE" > /dev/null
    fi
}
