#!/usr/bin/env bash

function echoheader() {
  echo -e "\e[35m$1\e[39m\n"
}

function echotext() {
  echo -e "\e[36m$1 ...\e[39m"
}

function echosuccess() {
  echo -e "\e[32m$1 ✓\e[39m\n"
}

clear

echoheader "Sublime Drupal Editor Installer"

echotext "Install dependencies (software-properties-common,apt-transport-https,wget,nodejs)"
sudo apt update -qq -y
sudo apt install software-properties-common apt-transport-https wget -qq -y
sudo apt install nodejs -qq -y
sudo apt install php-cli php-xml php-mbstring -qq -y

php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer
sudo chown -R $USER ~/.composer

composer global require "squizlabs/php_codesniffer=*"

composer global require drupal/coder
phpcs --config-set installed_paths /home/tim/.config/composer/vendor/drupal/coder/coder_sniffer

echosuccess "Install dependencies"

echotext "Get sublime gpgkey"
wget -q https://packagecloud.io/AtomEditor/atom/gpgkey -O- | sudo apt-key add -
echosuccess "Get sublime gpgkey"

echotext "Add repository"
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
echosuccess "Add repository"

echotext "Install sublime"
sudo apt install sublime-text -qq -y
echosuccess "Install sublime"
