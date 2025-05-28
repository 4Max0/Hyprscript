# -------------------------------------------------------------------
# --- TMUX auto start -----------------------------------------------
# -------------------------------------------------------------------

# Check if tmux installed
if command -v tmux &> /dev/null; then
  	# Check if session default is existent
  	if ! tmux has-session -t default 2>/dev/null; then
    		tmux new-session -d -s default
  	fi

  	# If we arent in a session we do this
  	if [[ -z "$TMUX" ]]; then
    	# fzf session choosing
    	selected_session=$(tmux list-sessions -F "#{session_name}" | fzf --prompt="Choose a session: ")

    	# try to connect
    	if [[ -n "$selected_session" ]]; then
      		tmux attach-session -t "$selected_session"
    	fi
  	fi
fi
