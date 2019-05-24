#!/bin/sh
# This will create symlinks for our dotfiles
# Must be run in the directory of our dotfiles repo

#bash
if [ -f "$HOME/.bash_profile" ]; then
  if [ -L "$HOME/.bash_profile" ]; then
    ln -sf $PWD/.bash_profile $HOME/.bash_profile
  else
    echo "ERROR: $HOME/.bash_profile is a file, NOT a symlink. Check or remove before retrying\n"
  fi
else
  ln -sf $PWD/.bash_profile $HOME/.bash_profile
fi

if [ -f "$HOME/.bashrc" ]; then
  if [ -L "$HOME/.bashrc" ]; then
    ln -sf $PWD/.bashrc $HOME/.bashrc
  else
    echo "ERROR: $HOME/.bashrc is a file, NOT a symlink. Check or remove before retrying\n"
  fi
else
  ln -sf $PWD/.bashrc $HOME/.bashrc
fi

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

#emacs
if [ -d "$HOME/.emacs.d" ]; then
  if [ -L "$HOME/.emacs.d" ]; then
    ln -sf $PWD/.emacs.d $HOME/.emacs.d
  else
    echo "ERROR: $HOME/.emacs.d is a dir, NOT a symlink. Check or remove before retrying\n"
  fi
else
  ln -sf $PWD/.emacs.d $HOME/.emacs.d
fi

#tmux
if [ -f "$HOME/.tmux.conf" ]; then
  if [ -L "$HOME/.tmux.conf" ]; then
    ln -sf $PWD/.tmux/slim.tmux.conf $HOME/.tmux.conf
  else
    echo "ERROR: $HOME/.tmux.conf is a file, NOT a symlink. Check or remove before retrying\n"
  fi
else
  ln -sf $PWD/.tmux/slim.tmux.conf $HOME/.tmux.conf
fi

if [ -d "$HOME/.tmux" ]; then
  if [ -L "$HOME/.tmux" ]; then
    ln -sf $PWD/.tmux $HOME/.tmux
  else
    echo "ERROR: $HOME/.tmux is a dir, NOT a symlink. Check or remove before retrying\n"
  fi
else
  echo "no home/.tmux dir\n"
  ln -sf $PWD/.tmux $HOME/.tmux
fi
