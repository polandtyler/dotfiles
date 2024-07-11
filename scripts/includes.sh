#!/bin/bash

gray() {
  yellow $1
  # echo "$(tput bold)$(tput setaf 0)[*] $1$(tput sgr0)"
}

green() {
  echo "$(tput setaf 2)[+] $1$(tput sgr0)"
}

yellow() {
  echo "$(tput setaf 3)[!] $1$(tput sgr0)"
}

red() {
  echo "$(tput setaf 1)[-] $1$(tput sgr0)"
}
