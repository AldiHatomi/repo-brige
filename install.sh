#!/bin/bash 

apt install figlet ruby
mkdir dvd
gem install lolcat
chmod 777 logo
chmod 777 repo
chmod 777 tools.sh
rm install.sh
./repo | lolcat
