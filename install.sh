#!/bin/bash
set -euo pipefail

LOGFILE="$HOME/script-config-ubuntu/logs/[LOG-INSTALACAO]-[$(date +%d-%m-%Y)-$(date +%H:%M)].log"
mkdir -p "$HOME/script-config-ubuntu/logs"
touch "$LOGFILE"

sudo add-apt-repository main -y
sudo add-apt-repository universe -y
sudo add-apt-repository multiverse -y
sudo add-apt-repository restricted -y
sudo add-apt-repository ppa:zhangsongcui3371/fastfetch -y
sudo add-apt-repository ppa:danielrichter2007/grub-customizer -y

# Adiciona o pacote Office
# sudo add-apt-repository ppa:libreoffice/ppa -y

# Adiciona o pacote Obs-Studio
# sudo add-apt-repository ppa:obsproject/obs-studio -y

sudo apt update && sudo apt upgrade -y
sudo ubuntu-drivers install | tee -a $LOGFILE
sudo apt install -y build-essential linux-headers-generic software-properties-common mesa-vulkan-drivers net-tools fastfetch fzf curl jq \
rar unrar zip unzip htop btop wget ffmpeg vlc gimp git-lfs make cmake default-jdk ack-grep fontconfig imagemagick vim vim-gtk3 dirmngr \
gawk silversearcher-ag coreutils gpg plocate gnome-tweaks | tee -a $LOGFILE

mkdir -p "$HOME/Apps"
mkdir -p "$HOME/Customizacao"

# Dotfiles de customização de terminal (by Daniruiz)
git clone https://github.com/daniruiz/dotfiles.git "$HOME/Customização"

# Instalando o Docker
sudo apt remove $(dpkg --get-selections docker.io docker-compose docker-compose-v2 docker-doc podman-docker containerd runc | cut -f1)
sudo apt update
sudo apt install ca-certificates
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

sudo tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Signed-By: /etc/apt/keyrings/docker.asc
EOF

sudo apt update && sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

# Instalando PostgreSQL e PGadmin4
sudo apt install -y postgresql-common
sudo /usr/share/postgresql-common/pgdg/apt.postgresql.org.sh
sudo apt install -y postgresql-18 libpq-dev postgresql-doc-18 postgresql-server-dev-18 postgresql-client-18

curl -fsS https://www.pgadmin.org/static/packages_pgadmin_org.pub | sudo gpg --dearmor -o /usr/share/keyrings/packages-pgadmin-org.gpg
sudo sh -c 'echo "deb [signed-by=/usr/share/keyrings/packages-pgadmin-org.gpg] https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/$(lsb_release -cs) pgadmin4 main" > /etc/apt/sources.list.d/pgadmin4.list && apt update'
sudo apt install -y pgadmin4 pgadmin4-desktop pgadmin4-web
sudo /usr/pgadmin4/bin/setup-web.sh

# Instalando Visual Studio Code
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /usr/share/keyrings/microsoft.gpg > /dev/null
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list
sudo apt install apt-transport-https && sudo apt update && sudo apt install code -y

# Instalando o Claude code AI
curl -fsSL https://claude.ai/install.sh | bash | tee -a $LOGFILE

# Instalando Grub-Customizer
sudo apt install -y grub-efi grub2-common grub-customizer
sudo grub-install

# Instalando Spotify
curl -sS https://download.spotify.com/debian/pubkey_5384CE82BA52C83A.asc | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
echo "deb https://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list

sudo apt update && sudo apt install spotify-client -y

# Instalando Homebrew
mkdir -p "$HOME/.homebrew" && git clone https://github.com/Homebrew/brew $HOME/.homebrew

eval "$($HOME/.homebrew/bin/brew shellenv)"
brew update --force --quiet
chmod -R go-w "$(brew --prefix)/share/zsh"

clear
echo "Para concluir as configurações o sistema sera reiniciado em 5 seg!"
sleep 5
sudo shutdown -r now
