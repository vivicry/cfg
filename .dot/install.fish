#!/usr/bin/fish

# Set up ssh first before running this
set -gx CFG_PATH "$HOME/.cfg/"
alias cfg="/usr/bin/git --git-dir=$CFG_PATH/ --work-tree=$HOME"
git clone --bare git@github.com:viviVividly/cfg.git $CFG_PATH
cfg config --local status.showUntrackedFiles no
