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

echoheader "Atom Drupal Editor UNINSTALL"

echotext "Uninstall dependencies (software-properties-common,apt-transport-https,wget,nodejs)"
sudo apt -qq remove  -y --purge software-properties-common apt-transport-https wget
sudo apt -qq remove  -y --purge nodejs
sudo apt -qq remove  -y --purge php-cli

composer global remove squizlabs/php_codesniffer
#composer global remove drupal/coder
echosuccess "Uninstall dependencies"

echotext "Uninstall sublime"
sudo apt -qq remove -y --purge sublime-text
echosuccess "Uninstall sublime"
