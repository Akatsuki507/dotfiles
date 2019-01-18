# pacman/yay aliases
function search --description 'Search a package on Manjaro repos or AUR'
  switch $argv[1]
    case 1
      pacman -Ss $argv[2..-1]
    case 2
      yay -Ss --aur $argv[2..-1]
  end
end

function install --description 'Install a package from Manjaro repos or AUR'
  switch $argv[1]
    case 1
      sudo pacman -S $argv[2..-1]
    case 2
      yay -S --aur $argv[2..-1]
  end
end

function uninstall --description 'Uninstall a package along with its config and dependencies'
  switch $argv[1]
    case 1
      sudo pacman -Rns $argv[2..-1]
    case 2
      yay -Rns $argv[2..-1]
  end
end

function update --description 'Update Manjaro and AUR packages'
  sudo pacman -Syu; yay --aur -Syu
end

function downgrade --description 'Downgrade a package'
  sudo pacman -U $argv
end

function orphans --description 'Remove orphan packages'
  sudo pacman -Rns (pacman -Qtdq)
end

function clean --description 'Remove outdated/untracked packages'
  sudo pacman -Sc; yay -Sc
end

function dbsync --description 'Updates Manjaro repos and syncs the DB'
  sudo pacman -Syy
end

function mirrors --description 'Ranks Manjaro mirrors by speed, also filters the out-of-date ones'
  sudo pacman-mirrors -f 0; sudo pacman -Syy
end

# You need to install 'debtap' from AUR first
function debinstall --description 'Install .deb packages'
  sudo debtap $argv; sudo pacman -U *.pkg.tar.xz
end

# RVM aliases
function gemset
  rvm gemset use $argv
end

# NPM aliases
function npmgp --description 'Lists globally installed NPM packages'
  npm list -g --depth=0
end

# Shell aliases
function pathdirs --description 'Shows every dir on current PATH, one per line'
  for val in $PATH
    echo "Entry: $val"
  end
end

# Misc
# Original author: @sadasant on Github
function passphrase
  shuf -n4 /usr/share/dict/words | tr '\n' ' '
end

# Original author: @stefanmaric on Github
function mkcd --description 'Creates a directory and takes you inside'
  mkdir -p $argv[1]
  cd $argv[1]
end

function editconfig --description "Edit 'config.fish' file"
  nano ~/.config/fish/config.fish
end

function aliases --description 'Edit my aliases'
  nano ~/.config/fish/functions/aliases.fish
end

function extract --description 'Extract a .tar file properly'
  tar -xvzf $argv
end

# Bundler aliases
function bx --description 'Runs Ruby-based commands in current bundle context'
  bundle exec $argv
end

# You need to install 'youtube-dl' first
# sudo pacman -S youtube-dl
function dl --description 'Downloads a video from Youtube w/ metadata & embed thumbnail (if possible)'
  youtube-dl $argv --add-metadata --embed-thumbnail
end

function mimimi
  ruby ~/Code/playground/la_taguara_scripts/mimimi_speak.rb
end

# RSpec aliases
function rmodified --description 'Runs only modified specs using git status'
  bundle exec rspec (git status | grep spec | grep "modified:" | cut -b 14-)
end

function mspec --description 'Runs only added/modified tests using git diff'
  git diff --name-only --diff-filter=AMR origin/master | grep _spec.rb | xargs rspec
end

function testloop --description 'Runs RSpec tests on a loop for N times'
  for n in (seq 1 $argv[1])
    echo "Test try #$n"
    bundle exec rspec $argv[2..-1]
  end
end

# Baton alises
# You need to install https://github.com/joshuathompson/baton first
function bp --description 'Resumes Spotify playback'
  baton play
end

function bs --description 'Pauses Spotify playback'
  baton pause
end

# Multimedia functions
# For this script to work, you'll need the following packages first:
# 1. LAME encoder/decoder, v3.98  or higher
# 2. FLAC encoder/decoder, v1.3.2 or higher
# 3. GNU Parallel
# This script is intended to be used on the folder where the .flac
# files you want to convert are located
function ftm --description 'Converts .flac files to .mp3'
  mkdir tmp/ mp3/
  # Flags used for processing .flac files:
  # -d              -> Decode the given file into .wav
  # --output-prefix -> Save the final file to tmp/ folder
  parallel flac -d --output-prefix=tmp/ {} ::: ./*.flac
  # Flags used for processing .wav files:
  # -m j                  -> 'Joint stereo' channel setting
  # -V 0                  -> Enable VBR at the highest quality
  # -q 0                  -> Use the best algorithms to achieve the highest quality given the file's bitrate
  # --lowpass 19.5        -> Cutoff frequencies above 19.5 kHz
  # -b 32                 -> Sampling frecuency
  # --vbr-new             -> Latest VBR algorithm, faster than `--vbr-old`
  # --replaygain-accurate -> Determine real peak sample
  # --out-dir mp3/        -> Output the converted files to mp3/ folder
  parallel lame {} -m j -V 0 -q 0 --lowpass 19.5 --vbr-new -b 32 --replaygain-accurate --out-dir mp3/ ::: ./tmp/*.wav
  rm -rf tmp/
end

# Misc
function weather --description 'Fetch current weather for location passed as argv'
  curl wttr.in/$argv
end

