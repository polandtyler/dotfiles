echo "\033[32mCreating dotfile links in home dir."
echo "\033[0m"

REPO_DIR="$(pwd)"
VIM_HOME="$(pwd)/vim"
echo "repo dir: $REPO_DIR"

ln -sf $VIM_HOME ~/.vim
ln -sf ~/.vim/vimrc ~/.vimrc
mkdir -p ~/.config
ln -sf ~/.vim ~/.config/nvim

ln -sf $REPO_DIR/zsh/zshrc ~/.zshrc
ln -sf $REPO_DIR/tmux.conf ~/.tmux.conf
