DIR="$( cd -P "$( dirname "$0" )" >/dev/null 2>&1 && pwd )"
source "${DIR}/../includes.sh"

gray "Install brew"

if ! hash brew &> /dev/null; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  gray "Checking if brew has issues"
  brew doctor
else
  gray "Skipping install, checking up-to-date"
  brew update
fi

if ! hash neovim &> /dev/null; then
  gray "Installing neovim"
  brew install neovim/neovim/neovim
else
  yellow "neovim installed"
fi

if ! hash autojump &> /dev/null; then
  gray "Installing autojump"
  brew install autojump
else
  yellow "Autojump installed"
fi

gray "Install tmux"

if ! hash tmux &> /dev/null; then
  brew install tmux
else
  yellow "Skipping, already installed"
fi

gray "Install ripgrep"

if ! hash rg &> /dev/null; then
  brew install ripgrep
else
  yellow "Skipping, already installed"
fi

