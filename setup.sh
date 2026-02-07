<<<<<<< HEAD
#!/bin/bash
if [[ $EUID -ne 0 ]]; then
   echo "Execute com sudo! [ sudo ./setup.sh ]"
   exit 1
fi

AMARELO='\e[1;33m'
PADRAO='\033[0m'

echo 'menu() { bash "$HOME/menu.sh"}' >> ~/.bashrc

echo "Instalando dependencias básicas..."
sudo apt install -y curl jq gpg
clear

echo "Dependencias básicas instaladas!"
echo "rode: ${AMARELO}menu${PADRAO} para iniciar o menu de opções."
||||||| parent of ef975cc ((add) instala dependências do projeto e cria pasta de logs)
=======
#!/bin/bash
sudo apt install -y curl jq gpg

mkdir ~/config-ubuntu-based/logs
>>>>>>> ef975cc ((add) instala dependências do projeto e cria pasta de logs)
