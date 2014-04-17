" Vundle {
	filetype off
	
	set rtp+=~/.vim/bundle/vundle/
	call vundle#rc()
	
	" Bundles {
		Bundle 'gmarik/vundle'
		Bundle 'tpope/vim-unimpaired'
		Bundle 'jeffkreeftmeijer/vim-numbertoggle'
		Bundle 'scrooloose/nerdtree'
		Bundle 'tpope/vim-fugitive'
		Bundle 'tomtom/tcomment_vim'
		Bundle 'kien/ctrlp.vim'
	" }
	
	filetype plugin indent on
" }

let mapleader = ','
set nocompatible
set hidden
set tabstop=4 softtabstop=4 shiftwidth=4
set relativenumber
set spell
set wrap linebreak nolist
syntax on
colorscheme desert

if has('autocmd')
	
end

" Mappings {
	" Bubbling
	nmap <C-S-Up> [e
	nmap <C-S-Down> ]e
	
	nmap <C-S-k> [e
	nmap <C-S-j> ]e

	" Visual Bubbling
	vmap <C-S-Up> [egv
	vmap <C-S-Down> ]egv
	
	vmap <C-S-k> [egv
	vmap <C-S-j> ]egv

	" Commenting
	nmap <leader>c gcc

	" Visual Commenting
	vmap <leader>c gc
	
	" NERDTree
	nmap <silent> <leader>n :NERDTreeToggle<cr>
	
	" Moving between panes
	map <C-Up> <C-w>k
	map <C-Down> <C-w>j
	map <C-Left> <C-w>h
	map <C-Right> <C-w>l

	map <M-Up> <C-w>k
	map <M-Down> <C-w>j
	map <M-Left> <C-w>h
	map <M-Right> <C-w>l

	map <C-k> <C-w>k
	map <C-j> <C-w>j
	map <C-h> <C-w>h
	map <C-l> <C-w>l

	map <M-k> <C-w>k
	map <M-j> <C-w>j
	map <M-h> <C-w>h
	map <M-l> <C-w>l
" }
