DIR="$( cd -P "$( dirname "$0" )" >/dev/null 2>&1 && pwd )"
source "${DIR}/../includes.sh"

gray "Install brew"

if ! hash brew &> /dev/null; then
  curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh > /tmp/brew.install.sh
  /bin/bash /tmp/brew.install.sh
  gray "Checking if brew has issues"
  brew doctor
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  gray "Skipping install, checking up-to-date"
  brew update
fi

brew_install() {
  pkg=$1

  if ! hash "$pkg" &> /dev/null; then
    gray "Installing $pk"
    brew install "${pkg}"
  else
    yellow "Skipping ${pkg}, already installed!"
  fi
}

declare -a packages=( neovim/neovim/neovim autojump tmux ripgrep cheat gnu-sed asdf )
for p in "${packages[@]}"; do
  brew_install "${p}"
done

brew install zsh-syntax-highlighting
brew install reattach-to-user-namespace

source "$HOME/.asdf/asdf.sh"

declare -a asdf_pkgs=( python ruby node )
for p in "${asdf_pkgs}"; do
  asdf plugin add $p
  asdf install $p latest
  asdf global $p latest
done

npm install -g neovim
pip3 install pynvim
gem install neovim
