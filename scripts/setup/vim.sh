VIM_HOME=~/dotfiles/vim

echo "\033[32mInstall vim"
echo "\033[0m"

brew install vim

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

VUNDLE=$VIM_HOME/bundle/Vundle.vim
if [ ! -d $VUNDLE ]; then
  git clone https://github.com/gmarik/Vundle.vim.git $VUNDLE
else
  echo "\033[32mSkipping, already exists"
  echo "\033[0m"
fi

echo "\033[32mInstall vim plugins"
echo "\033[0m"

vim +PluginInstall +qall

