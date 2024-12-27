#!/bin/bash

# uncommend this if not in devcontainer

######

# update the node
sudo apt update -y
sudo apt upgrade -y

# install the jdk
sudo apt install openjdk-17-jdk -y

######

# get minecraft server for 1.21.1
wget https://piston-data.mojang.com/v1/objects/59353fb40c36d304f2035d51e7d6e6baa98dc05c/server.jar

# try to start the server (this creates the eula file)
java -Xmx1024M -Xms1024M -jar server.jar nogui

# now edit the eula file
file="eula.txt"

if [ -s "$file" ]; then
    # Remove the last line from the file
    sed -i '$ d' "$file"

    # Append a new line at the end of the file
    echo "eula=true" >> "$file"
else
    echo "File $file does not exist or is empty."
fi

# get ngrok (port forwarding)
wget https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3stable-linux-amd64.tgz
tar -xvzf ngrok-v3stable-linux-amd64.tgz
./ngrok authtoken $1

# make 2 terminals (pannes)
# pane1 for the server
# pane2 for port forwarding

# Check if tmux is installed, if not, install it
if ! command -v tmux &> /dev/null; then
  echo "tmux not found. Installing..."
  sudo apt-get update
  sudo apt-get install -y tmux
fi

# Create a new tmux session named 'my_session' with one window
tmux new-session -d -s my_session -n 'MainWindow'

# Split the window into two horizontal panes
tmux split-window -h

command_pane1="java -Xmx12288M -Xms12288M -jar server.jar nogui; exec bash"
command_pane2="./ngrok tcp 25565; exec bash"

# Send commands to panes
tmux send-keys -t my_session:0.0 "$command_pane1" C-m

# uit testing bleek dat de server klaar komt (ludo reference) na 20 seconden -_-
for (( i = 20; i >= 1; i-- )); do
    echo "Setting up your Minecraft 1.21 server and IP in $i seconds"
    sleep 1;
done

tmux send-keys -t my_session:0.1 "$command_pane2" C-m

# Attach to the tmux session
tmux attach-session -t my_session
