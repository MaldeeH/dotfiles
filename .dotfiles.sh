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

dotpull () {
  # Ensure we’re using the bare-repo setup
  alias config='git --git-dir=$HOME/.cfg/ --work-tree=$HOME' >/dev/null 2>&1 || true

  # Refuse to overwrite local modifications unless forced
  if ! config diff --quiet || ! config diff --cached --quiet; then
    echo "dotpull: you have local changes. Commit/stash them first, or run: dotpull --force"
    return 1
  fi

  # Update from remote (uses upstream tracking branch)
  config pull --rebase

  # Ensure $HOME reflects the repo (usually redundant after pull, but keeps things consistent)
  config checkout

  echo "dotpull: updated."
}
