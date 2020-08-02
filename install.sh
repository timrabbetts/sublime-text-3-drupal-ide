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
sudo apt -qq -y update
sudo apt -qq -y install software-properties-common apt-transport-https wget
sudo apt -qq -y install nodejs
sudo apt -qq -y install php-cli

php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer
sudo chown -R $USER ~/.composer

composer global require "squizlabs/php_codesniffer=*"

composer global require drupal/coder
phpcs --config-set installed_paths ~/.composer/vendor/drupal/coder/coder_sniffer

echosuccess "Install dependencies"

echotext "Get atom gpgkey"
wget -q https://packagecloud.io/AtomEditor/atom/gpgkey -O- | sudo apt-key add -
echosuccess "Get atom gpgkey"

echotext "Add repository"
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
echosuccess "Add repository"

echotext "Install sublime"
sudo apt -qq install sublime-text
echosuccess "Install sublime"

#echotext "Install atom packages"
#source install_atom_packages.sh
#echosuccess "Install atom packages"
