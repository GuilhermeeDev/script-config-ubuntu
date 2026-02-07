<<<<<<< HEAD
#!/bin/bash

# function logfile(){
#     DATA=$(date +%d-%m-%Y)
#     HORA=$(date +%H:%M)
#     LOGFILE="logs/[$1]-[$DATA-$HORA].log"
#     return $LOGFILE
# }

function add_repositories(){
    echo "Adicionando repositórios..."
    sudo apt update && sudo apt upgrade -y

    sudo add-apt-repository main -y
    sudo add-apt-repository universe -y
    sudo add-apt-repository multiverse -y
    sudo add-apt-repository restricted -y
    sudo add-apt-repository ppa:zhangsongcui3371/fastfetch -y
    # sudo add-apt-repository ppa:deadsnakes/ppa -y
    # sudo add-apt-repository ppa:graphics-drivers/ppa -y
    sudo add-apt-repository ppa:libreoffice/ppa -y
    sudo add-apt-repository ppa:obsproject/obs-studio -y

    sudo apt update && sudo apt upgrade -y
}
||||||| parent of 300252f ((update) Remoção de função de logs comentada;)
=======
#!/bin/bash

function add_repositories(){
    echo "Adicionando repositórios..."
    sudo add-apt-repository main -y
    sudo add-apt-repository universe -y
    sudo add-apt-repository multiverse -y
    sudo add-apt-repository restricted -y
    sudo add-apt-repository ppa:zhangsongcui3371/fastfetch -y
    sudo add-apt-repository ppa:libreoffice/ppa -y
    sudo add-apt-repository ppa:obsproject/obs-studio -y

    sudo apt update && sudo apt upgrade -y
}
>>>>>>> 300252f ((update) Remoção de função de logs comentada;)
