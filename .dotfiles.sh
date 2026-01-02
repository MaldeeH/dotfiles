# dotfiles bare-repo helper
alias config='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

dotpush () {
  # Stage ONLY the whitelisted paths (includes new files under .config/)
  config add -A -- .zshrc .bashrc .tmux.conf .config

  # No staged changes? Stop quietly.
  if config diff --cached --quiet; then
    echo "dotpush: no changes."
    return 0
  fi

  config commit -m "Update $(date +'%Y-%m-%d %H:%M') $(uname -s)/$(uname -m)-$(hostname -s)"
  config push
}

