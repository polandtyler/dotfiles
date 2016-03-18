echo "\033[32mInstall brew"
echo "\033[0m"

if ! hash brew &> /dev/null; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  echo "\033[32mChecking if brew has issues"
  echo "\033[0m"
  brew doctor
else
  echo "\033[32mSkipping install, checking up-to-date"
  echo "\033[0m"
  brew update
fi

if ! hash neovim &> /dev/null; then
  echo "\033[32mInstalling neovim"
  echo "\033[0m"
  brew install neovim/neovim/neovim
else
  echo "\033[32mneovim installed"
  echo "\033[0m"
fi

if ! hash autojump &> /dev/null; then
  echo "\033[32mInstalling autojump"
  echo "\033[0m"
  brew install autojump
else
  echo "\033[32mAutojump installed"
  echo "\033[0m"
fi

echo "\033[32mInstall tmux"
echo "\033[0m"

if ! hash tmux &> /dev/null; then
  brew install tmux
else
  echo "\033[32mSkipping, already installed"
  echo "\033[0m"
fi

