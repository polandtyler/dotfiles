DIR="$( cd -P "$( dirname "$0" )" >/dev/null 2>&1 && pwd )"
source "${DIR}/../includes.sh"

VIM_HOME=~/dotfiles/vim

gray "Install vim"
brew install vim
green "Installed vim!"

gray "Creating ~/.vim_tmp: where vim is configured to store temporary files."

if [ ! -d ~/.vim_tmp ]; then
  mkdir ~/.vim_tmp;
fi

gray "Cloning Vundle for vim plugins"

VUNDLE=$VIM_HOME/bundle/Vundle.vim
if [ ! -d $VUNDLE ]; then
  git clone https://github.com/gmarik/Vundle.vim.git $VUNDLE
  green "Finished cloning vundle"
else
  yellow "Skipping, already exists"
fi

gray "Install vim plugins"
vim +PluginInstall +qall
green "Finished installing vim plugins"
