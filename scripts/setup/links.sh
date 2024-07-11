DIR="$( cd -P "$( dirname "$0" )" >/dev/null 2>&1 && pwd )"
source "${DIR}/../includes.sh"

gray "Creating dotfile links in home dir."
REPO_DIR=~/dotfiles
VIM_HOME="${REPO_DIR}/vim"

ln -sf $VIM_HOME ~/.vim
ln -sf ~/.vim/vimrc ~/.vimrc
mkdir -p ~/.config
ln -sf ~/.vim ~/.config/nvim

ln -sf $REPO_DIR/zsh/zshrc ~/.zshrc
ln -sf $REPO_DIR/tmux.conf ~/.tmux.conf

cp $REPO_DIR/zsh/theme/asimple.zsh-theme ~/.oh-my-zsh/themes/.

green "Finished creating dotfile links in home dir."
