#!/bin/sh

echo Creating bin dir
mkdir ~/bin 2> /dev/null

echo Linking files to bin dir
for file in $(ls ~/.files/bin); do
	echo Linking ~/bin/$file to ~/.files/bin/$file
	ln -s ~/.files/bin/$file ~/bin/;
done

echo Installing Vundle
mkdir -p ~/.vim/bundle 2> /dev/null
git clone git://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

echo Installing Powerline Font
mkdir ~/.fonts 2> /dev/null
wget -O ~/.fonts/PowerlineSymbols.otf https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf
fc-cache -vf ~/.fonts 2> /dev/null
mkdir -p ~/.config/fontconfig/conf.d/ 2> /dev/null
wget -O ~/.config/fontconfig/conf.d/10-powerline-symbols.conf https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf

echo Installing Nave
wget -O ~/bin/nave https://github.com/isaacs/nave/raw/master/nave.sh
chmod +x ~/bin/nave 2> /dev/null

echo Installing rbenv
git clone git://github.com/sstephenson/rbenv ~/.rbenv

echo Installing ruby-build
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build

echo Linking config files
ln -s ~/.files/tmux.conf ~/.tmux.conf 2> /dev/null
ln -s ~/.files/vimrc ~/.vimrc 2> /dev/null
mkdir ~/.i3 2> /dev/null
ln -s ~/.files/i3config ~/.i3/config 2> /dev/null
ln -s ~/.files/i3status.conf ~/.i3status.conf 2> /dev/null
ln -s ~/.files/zshrc ~/.zshrc 2> /dev/null
