set -gx VISUAL nvim
set -gx EDITOR nvim

if status is-interactive
# Commands to run in interactive sessions can go here
    if type -q tmux
        if not test -n "$TMUX" && not test -n "$ZED_TERM" && not test -n "$GRAM_TERM"
	        tmux attach-session -t default; or tmux new-session -s default
            hyfetch
	    end
    end
    zoxide init --cmd cd fish | source
end



