# Downloads dotfiles repository to current directory, then links dot-files
# into current user's home directory.
#
# Requires git.
#
# Easy run:
#
#   curl https://raw.github.com/wasbazi/dotfiles/main/get.dotfiles.sh | sh

REPO_OWNER="wasbazi"
REPO_HOST="github.com"
REPO_NAME="dotfiles"
REPO_DIR="$HOME/$REPO_NAME"
GIT_REPO_URL="https://$REPO_HOST/$REPO_OWNER/$REPO_NAME.git"

set -e

if [ ! -d ~/dotfiles ]; then
  gray "Downloading repository: $GIT_REPO_URL"

  git clone "$GIT_REPO_URL" "$REPO_DIR"
fi

green "Dotfiles installed!"

SCRIPT_DIR="$REPO_DIR/scripts/setup"
if [ ! -z "$1" ]; then
  case "$1" in
    essential)
      $SCRIPT_DIR/essential-programs.sh
      ;;
    links)
      $SCRIPT_DIR/links.sh
      ;;
    zsh)
      $SCRIPT_DIR/oh-my-zsh.sh
      ;;
    vim)
      $SCRIPT_DIR/vim.sh
      ;;
    *)
      echo $"Usage: $0 {essential|links|zsh|vim}"
      exit 1
  esac
  exit 0
fi


$SCRIPT_DIR/essential-programs.sh
$SCRIPT_DIR/links.sh
$SCRIPT_DIR/oh-my-zsh.sh
$SCRIPT_DIR/vim.sh
