# Use a base image of your choice
FROM ubuntu:22.04

# Set the working directory
WORKDIR /workspace

# Update and install necessary tools and dependencies
RUN apt-get update && apt-get install -y \
    sudo \
    wget \
    openjdk-17-jdk \
    tmux \
    tar \
    curl \

# Ensure the script is executable
RUN chmod +x ./server.sh

# Run the script during container startup if needed
ENTRYPOINT ["bash"]

