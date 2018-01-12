# Path to Oh My Fish install.
set -q XDG_DATA_HOME
  and set -gx OMF_PATH "$XDG_DATA_HOME/omf"
  or set -gx OMF_PATH "$HOME/.local/share/omf"

# Customize Oh My Fish configuration path.
#set -gx OMF_CONFIG "/home/aitbw/.config/omf"

# Load oh-my-fish configuration.
source $OMF_PATH/init.fish

# Fish-specific settings
set -g theme_color_scheme base16
set -g theme_display_cmd_duration no

# Adds 'node' to current PATH
set -gx N_PREFIX $HOME/n
set -gx PATH $PATH $N_PREFIX/bin

# Adds 'scala' to current PATH
set -gx SCALA_HOME /usr/local/share/scala
set -gx PATH $PATH $SCALA_HOME/bin

rvm default
