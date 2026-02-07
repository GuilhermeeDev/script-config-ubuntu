#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "Execute com sudo! [ sudo ./main.sh ]"
   exit 1
fi

function menu(){
   echo "|====================================================|"
   echo "|                        MENU                        |"
   echo "|====================================================|"
   echo "| [1] Configuração completa do Script.               |"
   echo "| [2] Instalação de pacotes básicos.                 |"
   echo "| [3] Adição de repositórios.                        |"
   echo "| [4] Configuração do ASDF-v15 + Plugin              |"
   echo "| [5] Sair.                                          |"
   echo "|====================================================|"
   read -p "Escolha uma opção:" opcao
   case $opcao in
      1)
         # shellcheck disable=SC1091
         source .src/completedConfig.sh
      ;;
      2)
         source .src/basicConfig.sh
      ;;
      3)
         source .src/devConfig.sh
      ;;

      4)
         source .src/setup-asdf.sh
      ;;
      5) 
         echo "Saindo..."   
         exit 0
      ;;
      *) 
         echo "Saindo..."
         exit 0 
      ;;
   esac
}

menu