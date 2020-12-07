#!/usr/bin/env bash

# Install common tools I use with yay.

. "$( pwd )/utils.exclude.sh"

PROMPT='[ Yay Bootstraper ]'

echo_with_prompt "No need to run this script as root due to yay!"


# Update yay
yay -Syyu

# ---------------------------------------------
# Basic Utilities
# ---------------------------------------------

# Strace
yay -S strace

# Network tools, including netstat
yay -S net-tools


# ---------------------------------------------
# Programming Languages and Frameworks
# ---------------------------------------------

# NodeJS 
yay -S nodejs

# Yarn
yay -S yarn

# Golang
yay -S go go-tools

# Python
yay -S python pyhon3-pip

# ---------------------------------------------
# Tools I use often
# ---------------------------------------------

# Git, obviously
yay -S git

# Docker for containerization
# Official installation instructions: https://docs.docker.com/install/linux/docker-ce/ubuntu/
yay -S docker docker-compose

# Kitty
yay -S kitty

echo_with_prompt "Adding current user to docker group"
# Add user to docker group
sudo usermod -aG docker $USER 

echo_with_prompt "Verifying docker installation using a hello world container..."
# Verify the installaiton
docker run hello-world

# NeoVim
yay -S neovim

# htop
yay -S htop

# ---------------------------------------------
# Misc
# ---------------------------------------------

# Zsh 
yay -S zsh
echo_with_prompt "Installing Oh-my-zsh framework".
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Cleanup the cache (TODO: set up a cron to do this)
apt clean
