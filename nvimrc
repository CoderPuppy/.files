" vim-plug {
	call plug#begin('~/.nvim/plugged')
	
	" Plugins {
		Plug 'tpope/vim-unimpaired'
		Plug 'jeffkreeftmeijer/vim-numbertoggle'
		Plug 'scrooloose/nerdtree'
		Plug 'tpope/vim-fugitive'
		Plug 'tpope/vim-surround'
		Plug 'tomtom/tcomment_vim'
		Plug 'kien/ctrlp.vim'
		Plug 'gkz/vim-ls'
		Plug 'terryma/vim-multiple-cursors'
		Plug 'elixir-lang/vim-elixir'
		Plug 'vim-scripts/nxc.vim'
		Plug 'derekwyatt/vim-scala'
		Plug 'yamafaktory/lumberjack.vim'
		Plug 'sjl/gundo.vim'
		Plug 'danro/rename.vim'
		Plug 'Lokaltog/vim-easymotion'
		Plug 'tfnico/vim-gradle'
		Plug 'elixir-lang/vim-elixir'
		Plug 'rking/ag.vim'
	" }
	
	call plug#end()
" }

let g:python_host_prog='/usr/bin/python2'
let mapleader = ','
set nocompatible
set hidden
set tabstop=2 shiftwidth=2
set relativenumber
" set spell
set wrap linebreak nolist
set foldmethod=indent foldignore= foldlevelstart=9999
set timeoutlen=1000 ttimeoutlen=0
syntax on
colorscheme lumberjack

if has('mouse')
	set mouse=a
end

if has('autocmd')
	
end

" Mappings {
	" Commenting
	nmap <leader>c gcc

	" Visual Commenting
	vmap <leader>c gc
	
	" NERDTree
	nmap <silent> <leader>n :NERDTreeToggle<cr>
	
	noremap <C-j> <C-w>h
	noremap <C-k> <C-w>j
	noremap <C-l> <C-w>k
	noremap <C-;> <C-w>l

	noremap ; l
	noremap l k
	noremap k j
	noremap j h

	nnoremap gp :CtrlP<cr>
	map gu <Plug>(easymotion-prefix)
	map gi <Plug>(easymotion-s2)
	map gj <Plug>(easymotion-linebackward)
	map gk <Plug>(easymotion-j)
	map gl <Plug>(easymotion-k)
	map g; <Plug>(easymotion-lineforward)
	map / <Plug>(easymotion-sn)
	omap / <Plug>(easymotion-tn)

	nnoremap gb :ls<CR>:b<Space>
" }
