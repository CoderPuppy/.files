#!/bin/sh

echo Removing Vundle
rm -rf ~/.vim/bundle/vundle/ 2> /dev/null

echo Removing Powerline Font
rm ~/.config/fontconfig/conf.d/10-powerline-symbols.conf 2> /dev/null
rm ~/.fonts/PowerlineSymbols.otf 2> /dev/null

echo Unlinking executables
for file in "$(ls ~/.files/bin)"; do
	rm ~/bin/$file;
done

echo Removing Nave
rm ~/bin/nave 2> /dev/null

echo Removing RBEnv
rm -rf ~/.rbenv

echo Unlinking configs
rm ~/.tmux.conf 2> /dev/null
rm ~/.vimrc 2> /dev/null
rm ~/.i3/config 2> /dev/null
rm ~/.i3status.conf 2> /dev/null
rm ~/.zshrc 2> /dev/null
rm ~/.xinitrc 2> /dev/null
