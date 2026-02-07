<<<<<<< HEAD
#!/bin/bash
source .src/functions.sh

LOGFILE="logs/[Configuracao-basica]-[$(date +%d-%m-%Y)-$(date +%H:%M)].log"

packages=(  
    "mesa-vulkan-drivers"
    "net-tools"
    "network-manager"
    "fastfetch"
    "openssh-client"
    "fzf"
    "rar"
    "unrar"
    "zip"
    "unzip"
    "htop"
    "btop"
    "wget"
    "ffmpeg"
    "vlc"
    "gimp"
    "libreoffice"
)

add_repositories | tee -a $LOGFILE

# Garantia de configuracao de drivers
sudo ubuntu-drivers install | tee -a $LOGFILE

# Instalacao de pacotes de minha preferencia
sudo apt install -y "${packages[@]}" | tee -a $LOGFILE

mkdir "$HOME"/Apps

# Atualizacao final do sistema
sudo apt update && sudo apt upgrade -y | tee -a $LOGFILE

||||||| parent of faba326 ((fix) Correção de pacotes basicos de uso do Ubuntu.)
=======
#!/bin/bash
source .src/functions.sh

LOGFILE="logs/[Configuracao-basica]-[$(date +%d-%m-%Y)-$(date +%H:%M)].log"
touch $LOGFILE

packages=(  
    "mesa-vulkan-drivers"
    "net-tools"
    "network-manager"
    "fastfetch"
    "fzf"
    "rar"
    "unrar"
    "zip"
    "unzip"
    "htop"
    "btop"
    "wget"
    "vlc"
    "git"
)

add_repositories | tee -a $LOGFILE

# Garantia de configuracao de drivers
sudo ubuntu-drivers install | tee -a $LOGFILE

# Instalacao de pacotes de minha preferencia
sudo apt install -y "${packages[@]}" | tee -a $LOGFILE

mkdir "$HOME"/Apps

sudo apt update && sudo apt upgrade -y | tee -a $LOGFILE

>>>>>>> faba326 ((fix) Correção de pacotes basicos de uso do Ubuntu.)
