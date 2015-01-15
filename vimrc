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
		Bundle 'gkz/vim-ls'
		Bundle 'terryma/vim-multiple-cursors'
	" }
	
	filetype plugin indent on
" }

let mapleader = ','
set nocompatible
set hidden
set tabstop=2 softtabstop=2 shiftwidth=2
set relativenumber
set spell
set wrap linebreak nolist
set foldmethod=indent foldignore= foldlevelstart=9999
syntax on
colorscheme desert

if has('mouse')
	set mouse=a
end

if has('autocmd')
	
end

" Mappings {
	"" Bubbling
	"nmap <C-S-Up> [e
	"nmap <C-S-Down> ]e
	"
	"nmap <C-S-k> [e
	"nmap <C-S-j> ]e
	"
	"" Visual Bubbling
	"vmap <C-S-Up> [egv
	"vmap <C-S-Down> ]egv
	"
	"vmap <C-S-k> [egv
	"vmap <C-S-j> ]egv

	" Commenting
	nmap <leader>c gcc

	" Visual Commenting
	vmap <leader>c gc
	
	" NERDTree
	nmap <silent> <leader>n :NERDTreeToggle<cr>
	
	map <C-w>j <C-w>h
	map <C-w>k <C-w>j
	map <C-w>l <C-w>k
	map <C-w>; <C-w>l

	noremap ; l
	noremap l k
	noremap k j
	noremap j h
" }
