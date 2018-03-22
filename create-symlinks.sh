#!/bin/sh
# This will create symlinks for our dotfiles
# Must be run in the directory of our dotfiles repo

#vim
if [ -d "$HOME/.vim" ]; then
  if [ -L "$HOME/.vim" ]; then
    ln -sf $PWD/.vim $HOME/.vim
  else
    echo "ERROR: $HOME/.vim is a dir, NOT a symlink. Check or remove before retrying\n"
  fi
else
  ln -sf $PWD/.vim $HOME/.vim
fi

if [ -f "$HOME/.vimrc" ]; then
  if [ -L "$HOME/.vimrc" ]; then
    ln -sf $PWD/.vimrc $HOME/.vimrc
  else
    echo "ERROR: $HOME/.vimrc is a file, NOT a symlink. Check or remove before retrying\n"
  fi
else
  ln -sf $PWD/.vimrc $HOME/.vimrc
fi


if [ -f "$HOME/.tmux.conf" ]; then
  if [ -L "$HOME/.tmux.conf" ]; then
    ln -sf $PWD/.tmux.conf $HOME/.tmux.conf
  else
    echo "ERROR: $HOME/.tmux.conf is a file, NOT a symlink. Check or remove before retrying\n"
  fi
else
  ln -sf $PWD/.tmux.conf $HOME/.tmux.conf
fi
