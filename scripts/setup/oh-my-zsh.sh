DIR="$( cd -P "$( dirname "$0" )" >/dev/null 2>&1 && pwd )"
source "${DIR}/../includes.sh"

echo "Install oh-my-zsh"

if [ ! -d ~/.oh-my-zsh ]; then
  curl -L http://install.ohmyz.sh | sh
else
  yellow "Skipping, already exists"
fi

gray "Cloning zsh-completions"
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions
green "Finished clone zsh-completions"
