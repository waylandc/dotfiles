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

if [ -f "$HOME/.zshrc" ]; then
  if [ -L "$HOME/.zshrc" ]; then
    ln -sf $PWD/.zshrc $HOME/.zshrc
  else
    echo "ERROR: $HOME/.zshrc is a file, NOT a symlink. Check or remove before retrying\n"
  fi
else
  ln -sf $PWD/.zshrc $HOME/.zshrc
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
  echo ".emacs.d exists\n"
  if [ -L "$HOME/.emacs.d" ]; then
    echo ".emacs.d symlink already exists\n"
#    ln -sf $PWD/.emacs.d $HOME/.emacs.d
  else
    echo "ERROR: $HOME/.emacs.d is a dir, NOT a symlink. Check or remove before retrying\n"
  fi
else
  echo ".emacs.d doesn't exist, creating symlink\n"
  ln -sf $PWD/.emacs.d $HOME/.emacs.d
fi

#doom emacs
if [ -d "$HOME/.doom.d" ]; then
  echo ".doom.d exists\n"
  if [ -L "$HOME/.doom.d" ]; then
    echo ".doom.d symlink already exists\n"
  else
    echo "ERROR: $HOME/.doom.d is a dir, NOT a symlink. Check or remove before retrying\n"
  fi
else
  echo ".doom.d doesn't exist, creating symlink\n"
  ln -sf $PWD/.doom.d $HOME/.doom.d
fi

#tmux
if [ -d "$HOME/.tmux" ]; then
  if [ -L "$HOME/.tmux" ]; then
    ln -sf $PWD/.tmux $HOME/.tmux
  else
    echo "ERROR: $HOME/.tmux is a dir, NOT a symlink. Check or remove before retrying\n"
  fi
else
  echo ".tmux doesn't exist, creating\n"
  ln -sf $PWD/.tmux $HOME/.tmux
fi

#if [ -f "$HOME/.tmux.conf" ]; then
#  if [ -L "$HOME/.tmux.conf" ]; then
#    ln -sf $PWD/.tmux/slim.tmux.conf $HOME/.tmux.conf
#  else
#    echo "ERROR: $HOME/.tmux.conf is a file, NOT a symlink. Check or remove before retrying\n"
#  fi
#else
#  echo ".tmux.conf doesn't exist, creating symlink\n"
#  ln -sf $PWD/.tmux/slim.tmux.conf $HOME/.tmux.conf
#fi

