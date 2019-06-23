#!/bin/sh

echo Creating bin dir
mkdir -p ~/.local/bin 2> /dev/null

echo Linking files to bin dir
for file in $(ls ~/.files/bin); do
	if [[ -x ~/.files/bin/$file ]]; then
		echo Linking ~/bin/$file to ~/.files/bin/$file
		ln -sT ~/.files/bin/$file ~/.local/bin/$file 2> /dev/null
	fi
done

echo Creating completion dir
mkdir ~/.zcompletion 2> /dev/null

echo Linking files to completion dir
for file in $(ls ~/.files/zsh/completion); do
	echo Linking ~/.zcompletion/$file to ~/.files/zsh/completion/$file
	ln -sT ~/.files/zsh/completion/$file ~/.zcompletion/$file 2> /dev/null
done

echo Installing vim-plug
curl -fLo ~/.files/vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# echo Installing Powerline Font
# mkdir ~/.fonts 2> /dev/null
# wget -O ~/.fonts/PowerlineSymbols.otf https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf
# fc-cache -vf ~/.fonts 2> /dev/null
# mkdir -p ~/.config/fontconfig/conf.d/ 2> /dev/null
# wget -O ~/.config/fontconfig/conf.d/10-powerline-symbols.conf https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf

# echo Installing Nave
# wget -O ~/bin/nave https://github.com/isaacs/nave/raw/master/nave.sh
# chmod +x ~/bin/nave 2> /dev/null

echo Installing Nodenv
git clone git://github.com/nodenv/nodenv.git ~/.nodenv

echo Installing Node-Build
git clone git://github.com/nodenv/node-build.git ~/.nodenv/plugins/node-build

echo Installing Pyenv
git clone git://github.com/yyuu/pyenv.git ~/.pyenv

echo Installing RBEnv
git clone git://github.com/sstephenson/rbenv ~/.rbenv

echo Installing Ruby-Build
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build

echo Installing LuaEnv
git clone https://github.com/cehoffman/luaenv.git ~/.luaenv

echo Install Lua-Build
git clone git://github.com/cehoffman/lua-build.git ~/.luaenv/plugins/lua-build

echo Linking config files
ln -sT ~/.files/tmux.conf ~/.tmux.conf 2> /dev/null
ln -sT ~/.files/vim ~/.config/nvim 2> /dev/null
echo source ~/.files/bashrc > ~/.bashrc 2>/dev/null
ln -sT ~/.files/i3 ~/.i3 2> /dev/null
ln -sT ~/.files/i3/status.conf ~/.i3status.conf 2> /dev/null
ln -sT ~/.files/zshenv ~/.zshenv 2> /dev/null
ln -sT ~/.files/zshrc ~/.zshrc 2> /dev/null
ln -sT ~/.files/xinitrc ~/.xinitrc 2> /dev/null
ln -sT ~/.files/xmodmaprc ~/.xmodmaprc 2> /dev/null
mkdir ~/.config 2> /dev/null
ln -sT ~/.files/bspwm ~/.config/bspwm 2> /dev/null
ln -sT ~/.files/XCompose ~/.XCompose 2> /dev/null
ln -sT ~/.files/agignore ~/.agignore 2> /dev/null
