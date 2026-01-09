#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "Execute com sudo"
   exit 1
fi

DATA=$(date +%d-%m-%Y)
HORA=$(date +%H:%M)
LOGFILE="[Script-ubuntu-baseds]-[$DATA-$HORA].log"

packages=(  
    "build-essential"
    "linux-headers-generic"
    "mesa-vulkan-drivers"
    "net-tools"
    "network-manager"
    "fastfetch"
    "ssh"
    "openssh-client"
    "fzf"
    "rar"
    "unrar"
    "zip"
    "unzip"
    "htop"
    "wget"
    "curl"
    "git"
    "git-lfs"
    "make"
    "cmake"
    "ffmpeg"
    "vlc"
    "gimp"
    "python3.10"
    "python3-pip"
    "python3.10-venv"
    "php"
)

function repos_oficiais(){
    sudo add-apt-repository main -y
    sudo add-apt-repository universe -y
    sudo add-apt-repository multiverse -y
    sudo add-apt-repository restricted -y
}

function repos_unoficiais(){
    sudo add-apt-repository ppa:deadsnakes/ppa -y
    sudo add-apt-repository ppa:graphics-drivers/ppa -y
    sudo add-apt-repository ppa:libreoffice/ppa -y
    sudo add-apt-repository ppa:obsproject/obs-studio -y
    sudo add-apt-repository ppa:ondrej/php -y
}

# Atualizacao inicial do sistema
sudo apt update && sudo apt upgrade

repos_oficiais | tee -a $LOGFILE
repos_unoficiais | tee -a $LOGFILE

# Garantia de configuracao de drivers
sudo ubuntu-drivers install | tee -a $LOGFILE

# Instalacao de pacotes de minha preferencia
sudo apt install -y "${packages[@]}" | tee -a $LOGFILE

# Configuracao de git
git config --global user.name "GuilhermeeDev"
git config --global user.email "guilhermee.dev.software@gmail.com"
git config --global init.defaultBranch main

# cd ..
# mkdir Apps 

# Atualizacao final do sistema
sudo apt update && sudo apt upgrade -y | tee -a $LOGFILE

