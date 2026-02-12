#!/bin/bash
set -euo pipefail

sudo apt install -y curl jq gpg

LOGFILE="$HOME/script-config-Ubuntu/logs/[Configuracao-Completa]-[$(date +%d-%m-%Y)-$(date +%H:%M)].log"
mkdir -p "$HOME/script-config-Ubuntu/logs"
touch "$LOGFILE"

sudo add-apt-repository main -y
sudo add-apt-repository universe -y
sudo add-apt-repository multiverse -y
sudo add-apt-repository restricted -y
sudo add-apt-repository ppa:zhangsongcui3371/fastfetch -y
sudo add-apt-repository ppa:libreoffice/ppa -y
sudo add-apt-repository ppa:obsproject/obs-studio -y

packages=(
   "build-essential"
   "linux-headers-generic"
   "software-properties-common"
   "mesa-vulkan-drivers"
   "net-tools"
   "fastfetch"
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
   "git-lfs"
   "make"
   "cmake"
   "default-jdk"
   "ack-grep"
   "fontconfig"
   "imagemagick"
   "vim"
   "vim-gtk3"
   "dirmngr"
   "gawk"
   "silversearcher-ag"
   "coreutils"
   "gpg"
   "plocate"
   "libreoffice"
   "gnome-tweaks"
)

sudo apt update && sudo apt upgrade -y

sudo ubuntu-drivers install | tee -a $LOGFILE

sudo apt install -y "${packages[@]}" | tee -a $LOGFILE

# # 2 - CRIAÇÃO DE PASTAS DE AMBIENTE E CUSTOMIZAÇÃO
mkdir "$HOME/Apps"
mkdir "$HOME/Customização"
git clone https://github.com/daniruiz/dotfiles.git "$HOME/Customização" || echo "Dotfiles já clonados"

mkdir "$HOME/.asdf"

git clone https://github.com/asdf-vm/asdf.git "$HOME/.asdf" --branch v0.15.0
echo . "$HOME/.asdf/asdf.sh" | tee -a ~/.bashrc
echo . "$HOME/.asdf/completions/asdf.bash" | tee -a ~/.bashrc
source ~/.bashrc

# # Instalando Plugins do ASDF - Java, NodeJS, Ruby, Python, PHP, Elixir, Golang, Rust, Crystal, Scala, Julia, Perl
# # Dependencias para NodeJS
sudo apt install -y python3 g++-12 gcc-12 python3-pip 
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git

# Dependencias para Erlang
sudo apt install -y autoconf m4 libwxgtk3.2-dev libwxgtk-webview3.2-dev libgl1-mesa-dev libglu1-mesa-dev libpng-dev libssh-dev unixodbc-dev xsltproc fop libxml2-utils libncurses-dev openjdk-11-jdk
asdf plugin add erlang https://github.com/asdf-vm/asdf-erlang.git

# Nao possui dependencias extras
asdf plugin add elixir https://github.com/asdf-vm/asdf-elixir
asdf plugin add golang https://github.com/asdf-community/asdf-golang.git
asdf plugin add java https://github.com/halcyon/asdf-java.git
asdf plugin add rust https://github.com/asdf-community/asdf-rust.git
asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git
asdf plugin add crystal https://github.com/asdf-community/asdf-crystal.git
asdf plugin add php https://github.com/asdf-community/asdf-php.git
asdf plugin add python https://github.com/asdf-community/asdf-python.git
asdf plugin add bun

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

source ~/.bashrc

clear
echo "Para concluir as configurações o sistema sera reiniciado em 5 seg!"
sleep 5
sudo shutdown -r now