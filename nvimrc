" vim-plug {
	call plug#begin('~/.nvim/plugged')
	
	" Plugins {
		Plug 'tpope/vim-unimpaired'
		" Disabled because I usually don't look at the linenumbers so I can just
		" use relativenumber
		" Plug 'jeffkreeftmeijer/vim-numbertoggle'
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
		Plug 'rust-lang/rust.vim'
		Plug 'JuliaLang/julia-vim'
	" }
	
	call plug#end()
" }

let g:python_host_prog='/usr/bin/python2'
let mapleader = ','
set nocompatible
set hidden
set tabstop=2 shiftwidth=2
set relativenumber number
" set spell
set wrap linebreak nolist
set foldmethod=indent foldignore= foldlevelstart=9999
set timeoutlen=1000 ttimeoutlen=0
syntax on
colorscheme lumberjack
hi LineNr ctermfg=darkgrey

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

	noremap <C-w>j <C-w>h
	noremap <C-w>k <C-w>j
	noremap <C-w>l <C-w>k
	noremap <C-w>; <C-w>l

	noremap ; l
	noremap l k
	noremap k j
	noremap j h

	" nnoremap gp :CtrlP<cr>
	map hu <Plug>(easymotion-prefix)
	map hj <Plug>(easymotion-linebackward)
	map hk <Plug>(easymotion-j)
	map hl <Plug>(easymotion-k)
	map h; <Plug>(easymotion-lineforward)
	map / <Plug>(easymotion-sn)
	omap / <Plug>(easymotion-tn)

	nnoremap gb :ls<CR>:b<Space>
" }
