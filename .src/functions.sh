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