#!/bin/zsh                                                                                                   

SESSIONNAME="chan_session"
tmux has-session -t $SESSIONNAME &> /dev/null

if [ $? != 0 ] # if does not exist 
 then
    tmux new-session -s $SESSIONNAME -n code -d # code is name of first window
    
    # Running script logic here 
		tmux new-window -t $SESSIONNAME -n 'backend'
		tmux send-keys -t $SESSIONNAME:1 'cd ~/core/lox' C-m
		
		tmux new-window -t $SESSIONNAME -n 'frontend'
		tmux send-keys -t $SESSIONNAME:2 'cd ~/core/lox/frontend' C-m
		
		tmux new-window -t $SESSIONNAME -n 'agent'
		tmux send-keys -t $SESSIONNAME:2 'cd ~/core/testing' C-m
		
		tmux new-window -t $SESSIONNAME -n 'postgres'
fi

tmux attach -t $SESSIONNAME 
