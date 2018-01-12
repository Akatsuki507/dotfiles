# Set nano as default editor
set -gx EDITOR nano

rvm default

# Add N to current PATH
set -gx N_PREFIX $HOME/n
set -gx PATH $PATH $N_PREFIX/bin

# Add pyenv to current PATH
set -gx PYENV_ROOT $HOME/.pyenv
set -gx PATH $PATH $PYENV_ROOT/bin

# Add Rust to current PATH
set -gx RUST_PREFIX $HOME/.cargo
set -gx PATH $PATH $RUST_PREFIX/bin

# Base16 shell
# if status --is-interactive
#  eval sh $HOME/.config/base16-shell/scripts/base16-seti.sh
# end

source ~/.config/fish/functions/aliases.fish
source ~/.asdf/asdf.fish

status --is-interactive; and source (pyenv init -|psub)
