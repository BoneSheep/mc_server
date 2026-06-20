#!/bin/bash
set -euo pipefail

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <ngrok-auth-token>"
  exit 1
fi

NGROK_AUTH_TOKEN="$1"

# Update the package lists and install required packages
sudo apt update -y
sudo apt upgrade -y
sudo apt install -y openjdk-25-jdk wget tar curl tmux

# Download the Minecraft server jar if not present
if [ ! -f server.jar ]; then
  wget https://piston-data.mojang.com/v1/objects/823e2250d24b3ddac457a60c92a6a941943fcd6a/server.jar
fi

# Accept the EULA before the server starts
cat > eula.txt <<'EOF'
eula=true
EOF

# Installeer ngrok alleen als het nog niet beschikbaar is
if ! command -v ngrok >/dev/null 2>&1; then
  curl -sSL https://ngrok-agent.s3.amazonaws.com/ngrok.asc \
    | sudo tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null

  echo "deb https://ngrok-agent.s3.amazonaws.com bookworm main" \
    | sudo tee /etc/apt/sources.list.d/ngrok.list >/dev/null

  sudo apt update
  sudo apt install -y ngrok
fi


ngrok config add-authtoken "$NGROK_AUTH_TOKEN"

# Create a detached tmux session for the Minecraft server and ngrok forwarding
SESSION_NAME="mc_server"

if tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
  echo "Tmux session '$SESSION_NAME' already exists. Reusing it."
else
  tmux new-session -d -s "$SESSION_NAME" -n 'minecraft'
  tmux send-keys -t "$SESSION_NAME":0.0 "java -Xmx1024M -Xms1024M -jar server.jar nogui" C-m
  tmux split-window -h -t "$SESSION_NAME":0
  tmux send-keys -t "$SESSION_NAME":0.1 "ngrok tcp 25565" C-m
fi

echo "Minecraft server and ngrok forwarding started in tmux session '$SESSION_NAME'."
echo "Attach with: tmux attach-session -t $SESSION_NAME"
