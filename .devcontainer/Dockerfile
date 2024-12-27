# Use a base image of your choice
FROM ubuntu:22.04

# Update and install necessary tools and dependencies
RUN apt-get update && apt-get install -y \
    sudo \
    wget \
    openjdk-17-jdk \
    tmux \
    tar \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /workspace

# Copy the repository content into the container
COPY . .

# Ensure the script is executable
RUN chmod +x ./server.sh

# Set the default shell to bash
SHELL ["/bin/bash", "-c"]

# Run the script during container startup if needed
ENTRYPOINT ["bash"]

