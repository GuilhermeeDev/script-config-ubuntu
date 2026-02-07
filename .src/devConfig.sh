#!/bin/bash
source .src/functions.sh

LOGFILE="logs/[Configuracao-dev]-[$(date +%d-%m-%Y)-$(date +%H:%M)].log"

add_repositories

packages=(
    "build-essential"
    "linux-headers-generic"
    "software-properties-common"
    "git-lfs"
    "make"
    "cmake"
    "default-jdk"
    "ack-grep"
    "fontconfig"
    "imagemagick"
    "vim-gtk3"
    "dirmngr"
    "gawk"
    "make"
    "cmake"
    "silversearcher-ag"
    "coreutils"
    "zip"
    "unzip"
)

sudo apt install "${packages[@]}" -y | tee -a $LOGFILE

# Instalando o ASDF
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.15.0
echo '. "$HOME/.asdf/asdf.sh"' >> .bashrc
echo '. "$HOME/.asdf/completions/asdf.bash"' >> .bashrc

# Instalando Plugins do ASDF
# Java, NodeJS, Ruby, Python, PHP, Elixir, Golang, Rust, Crystal, Scala, Julia, Perl

# Dependencias para NodeJS
sudo apt install -y python3 g++-12 gcc-12 python3-pip 
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git

# Dependencias para Erlang
sudo apt install -y install build-essential autoconf m4 libwxgtk3.2-dev libwxgtk-webview3.2-dev libgl1-mesa-dev libglu1-mesa-dev libpng-dev libssh-dev unixodbc-dev xsltproc fop libxml2-utils libncurses-dev openjdk-11-jdk
asdf plugin add erlang https://github.com/asdf-vm/asdf-erlang.git

# Nao possui dependencias extras
asdf plugin add elixir https://github.com/asdf-vm/asdf-elixir.
asdf plugin add golang https://github.com/asdf-community/asdf-golang.git
asdf plugin add java https://github.com/halcyon/asdf-java.git
asdf plugin-add rust https://github.com/asdf-community/asdf-rust.git
asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git
asdf plugin add crystal https://github.com/asdf-community/asdf-crystal.git
asdf plugin-add php https://github.com/asdf-community/asdf-php.git
asdf plugin add python https://github.com/asdf-community/asdf-python.git
asdf plugin add bun

echo -p "Instalar versões realeses padrão do Script? (S/N)"; read op
op=$(echo "$op" | tr '[:lower:]' '[:upper:]')

if [[ $op == "sim" || $op == "s"  ]]; then
    echo "Instalando versões latest dos plugins ASDF..."
    asdf install nodejs latest
    asdf install erlang latest
    asdf install elixir latest
    asdf install golang latest
    asdf install java latest
    asdf install rust latest
    asdf install ruby latest
    asdf install crystal latest
    asdf install php latest
    asdf install python latest
    asdf install bun latest

    echo ""
    echo "Configurando versões globais dos plugins ASDF..."
    asdf global bun latest
    asdf global python latest
    asdf global php latest
    asdf global ruby latest
    asdf global rust latest
    asdf global java latest
    asdf global golang latest
    asdf global elixir latest
    asdf global erlang latest
    asdf global nodejs latest
    asdf global crystal latest
fi 

# Instalando o Docker
sudo apt remove $(dpkg --get-selections docker.io docker-compose docker-compose-v2 docker-doc podman-docker containerd runc | cut -f1)
sudo apt update
sudo apt install ca-certificates curl
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

# Recarreganco o .bashrc
source .bashrc