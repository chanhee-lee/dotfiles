# Description
- .tmux.conf - Should be place in ~/.tmux/.tmux.conf
- start_tmux_session.sh - Boilerplate for script for setting up tmux sessions. Can be put anywhere but I like to put it at ~ 
This script is a placeholder for setting up tmux-sessions for work. Replace all under 

# Running script
```
chmod +x tmux_session_lox.sh
./tmux_session_lox.sh
```

# Reloading after .tmux.conf file changes
```
tmux source-file ~/.tmux.conf
```
