
#!/bin/zsh                                                                                                   

SESSIONNAME="chan_session"
tmux has-session -t $SESSIONNAME &> /dev/null

if [ $? != 0 ] # if does not exist 
 then
    tmux new-session -s $SESSIONNAME -n code -d # code is name of first window
    
    # Running script logic here 
fi

tmux attach -t $SESSIONNAME 
