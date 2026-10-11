#!/usr/bin/fish

# Define all the packages to be installed
set -l packages \
	foot \
	tmux \
	fish \
	zoxide \
	fzf \
	neovim \
	luarocks \
	hyfetch \
	fastfetch \
	otf-comicshanns-nerd \
	ranger \
	tree \
    tree-sitter-cli \
    lua51

# Install all the packages
sudo pacman -Syu $packages

# Clone tpm for tmux
if test -d ~/.tmux/plugins/tpm
    echo "tmux-plugins/tpm exists; skipping"
else
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
end
