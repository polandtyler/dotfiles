# Downloads dotfiles repository to current directory, then links vim dot-files
# into current user's home directory.
#
# Requires git.
#
# Easy run:
#
#   curl https://raw.github.com/wasbazi/dotfiles/master/get.vimfiles.sh | sh

# Put your github username on the next line
REPO_OWNER="wasbazi"
# REPO_HOST will generally be "github.com", but may be changed to something else
# if you're using a different git hosting service or if you have configured
# an alias in ~/.ssh/config, e.g. because you're using multiple identities.
REPO_HOST="github.com"
# The next line should contain the name of the repository.
REPO_NAME="dotfiles"
REPO_DIR=~/$REPO_NAME
GIT_REPO_URL="git@$REPO_HOST:$REPO_OWNER/$REPO_NAME.git"

if [ ! -d ~/dotfiles ]; then
  echo "\033[32mDownloading repository."
  echo "\033[0m"

  git clone $GIT_REPO_URL $REPO_DIR
fi

echo "\033[32mUpdating submodules."
echo "\033[0m"

cd $REPO_DIR
git submodule update --init

echo "\033[32mInstall oh-my-zsh"
echo "\033[0m"

if [ ! -d ~/.oh-my-zsh ]; then
  curl -L http://install.ohmyz.sh | sh
else
  echo "\033[32mSkipping, already exists"
  echo "\033[0m"
fi

echo "\033[32mCreating dotfile links in home dir."
echo "\033[0m"

VIMHOME=`pwd`"/vim"

ln -s $VIMHOME ~/.vim
ln -s ~/.vim/vimrc ~/.vimrc
ln -s ~/.vim/gvimrc ~/.gvimrc
ln -s $REPO_DIR/bash/bash_profile ~/.bash_profile
ln -sf $REPO_DIR/zsh/zshrc ~/.zshrc
ln -s $REPO_DIR/tmux.conf ~/.tmux.conf
ln -s $REPO_DIR/jshintrc ~/.jshintrc

echo "\033[32mCreating ~/.vim_tmp: where vim is configured to store temporary files."
echo "\033[0m"

if [ ! -d ~/.vim_tmp ]; then
  mkdir ~/.vim_tmp;
else
  echo "\033[32mSkipping, already exists"
  echo "\033[0m"
fi

echo "\033[32mCloning Vundle for vim plugins"
echo "\033[0m"

if [ ! -d $VIMHOME/bundle/Vundle.vim ]; then
  git clone https://github.com/gmarik/Vundle.vim.git $VIMHOME/bundle/Vundle.vim
else
  echo "\033[32mSkipping, already exists"
  echo "\033[0m"
fi

echo "\033[32mInstall vim plugins"
echo "\033[0m"

vim +PluginInstall +qall

echo "\033[32mInstall brew"
echo "\033[0m"

if [ command -v brew >/dev/null 2>&1 ]; then
  ruby "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
  echo "\033[32mChecking if brew has issues"
  echo "\033[0m"
  brew doctor
else
  echo "\033[32mSkipping install, checking up-to-date"
  echo "\033[0m"
  brew update
fi

echo "\033[32mInstall tmux"
echo "\033[0m"

if [ command -v tmux >/dev/null 2>&1 ]; then
  brew install tmux
else
  echo "\033[32mSkipping, already installed"
  echo "\033[0m"
fi

echo "\033[32mInstall vim"
echo "\033[0m"

brew install vim

echo "\033[32mDotfiles installed!"
echo "\033[0m"
