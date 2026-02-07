<<<<<<< HEAD
#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "Execute com sudo! [ sudo ./main.sh ]"
   exit 1
fi

function menu(){
   echo "==================================================="
   echo "                       MENU                        "
   echo "==================================================="
   echo "[1] Configuração completa do Script"
   echo "[2] Instalação de pacotes básicos"
   echo "[3] Configuração de ambiente de desenvolvimento"
   echo "[4] Adição de repositórios ubuntu-baseds"
   echo "[5] Configuração do Proxychain4"
   echo "[6] Configuração do ASDF + Plugins"
   echo "[7] Menu de Correções de Erros"
   echo "[8] Menu de customizações"
   echo "[9] Sair"
   echo "==================================================="
   read -p "Escolha uma opção:" opcao
   case $opcao in
      1) bash .src/completedConfig.sh ;;
      2) bash .src/basicConfig.sh ;;
      3) bash .src/devConfig.sh ;;
      4) bash .src/proxychainSetup.sh ;;
      5) bash .src/asdfSetup.sh ;;
      6) bash .src/correctionsScripts.sh ;;
      7) bash .src/correctionsScripts/menu.sh ;;
      8) bash .src/customizationsMenu.sh ;;
      9) 
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

||||||| parent of fe5b155 ((update) corrigindo opções adicionais no arquivo menu.sh)
=======
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

>>>>>>> fe5b155 ((update) corrigindo opções adicionais no arquivo menu.sh)
