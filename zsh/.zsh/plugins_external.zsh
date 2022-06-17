### shell history custom search enginge ###
# https://github.com/cantino/mcfly
eval "$(mcfly init zsh)"
export MCFLY_FUZZY=2
export MCFLY_LIGHT=TRUE
export MCFLY_KEY_SCHEME=vim

### load and unload environment variables depending on the current directory ###
# https://github.com/direnv/direnv
# export DIRENV_LOG_FORMAT=
# eval "$(direnv hook zsh)"
# _direnv_hook() {
# 	eval "$(direnv export zsh 2> >( egrep -v -e '^direnv: (loading|export|unloading)' ))"
# };
