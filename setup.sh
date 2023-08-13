#!/bin/bash

chmod +x *.sh

declare -A osInfo;
osInfo[/etc/redhat-release]=yum
osInfo[/etc/arch-release]=pacman
osInfo[/etc/gentoo-release]=emerge
osInfo[/etc/debian_version]=apt-get

for f in ${!osInfo[@]}
do
    if [[ -f $f ]];then
        echo ${osInfo[$f]} detected..
        echo Installing dependencies...
        if ((${osInfo[$f]} == apt-get)); then
            sudo apt-get install wget curl php unzip lolcat figlet npm nodejs jq xsel -y
            npm install -g localtunnel
        fi
        if ((${osInfo[$f]} == pacman)); then
            sudo pacman -S wget curl php unzip figlet npm nodejs jq xsel --noconfirm
            sudo pacman -S gem
            sudo gem install lolcat
            npm install -g localtunnel
        fi
        if ((${osInfo[$f]} == yum)); then
            sudo yum install wget curl php unzip lolcat figlet npm nodejs jq xsel
            npm install -g localtunnel
        fi
        if ((${osInfo[$f]} == emerge )); then
            sudo emerge -u wget curl php unzip lolcat figlet npm nodejs jq xsel
            npm install -g localtunnel
        fi

    fi


done
echo Installation Completed
echo Blackeye will start automtically.
echo if it does not start, type ./blackeye.sh manually. | lolcat
sleep 5; figlet Blackeye-im && ./blackeye.sh
