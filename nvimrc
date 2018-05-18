" vim-plug {
	call plug#begin('~/.local/share/nvim/site/plugged')
	
	" Plugins {
		Plug 'tpope/vim-unimpaired'
		" Disabled because I usually don't look at the linenumbers so I can just
		" use relativenumber
		" Plug 'jeffkreeftmeijer/vim-numbertoggle'
		Plug 'scrooloose/nerdtree'
		Plug 'tpope/vim-fugitive'
		Plug 'tpope/vim-surround'
		Plug 'tomtom/tcomment_vim'
		Plug 'Shougo/unite.vim'
		Plug 'gkz/vim-ls'
		Plug 'terryma/vim-multiple-cursors'
		Plug 'yamafaktory/lumberjack.vim'
		Plug 'danro/rename.vim'
		Plug 'Lokaltog/vim-easymotion'
		Plug 'tfnico/vim-gradle'
		Plug 'rking/ag.vim'
		Plug 'scrooloose/syntastic'
		Plug 'simnalamburt/vim-mundo'
		" Plug 'godlygeek/tabular'

		Plug 'elixir-lang/vim-elixir'
		Plug 'vim-scripts/nxc.vim'
		Plug 'derekwyatt/vim-scala'
		Plug 'rust-lang/rust.vim'
		Plug 'JuliaLang/julia-vim'
		Plug 'lambdatoast/elm.vim'
		Plug 'raichoo/purescript-vim'
		Plug 'idris-hackers/idris-vim'
		Plug 'weakish/rcshell.vim'
		Plug 'cespare/vim-toml'

		" Haskell
		Plug 'eagletmt/ghcmod-vim'
		Plug 'Shougo/vimproc.vim'
		Plug 'jpalardy/vim-slime'
		Plug 'Shougo/deoplete.nvim'
		Plug 'eagletmt/neco-ghc'
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
let g:rust_recommended_style = 0

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

set completeopt=longest,menuone
let g:deoplete#enable_at_startup = 1
let g:deoplete#disable_auto_complete = 1

let g:unite_source_rec_async_command = ['ag', '--hidden', '-g', '', '--nocolor']
call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])
call unite#custom#profile('default', 'context', {'start_insert': 1})
call unite#custom#source('file_rec/async', 'ignore_globs', ['**/.stack-work/**', '**/node_modules/**', '**/.*.swp', '**/.git/**'])

autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
	imap <buffer> <F5> <Plug>(unite_redraw)
	nmap <buffer> <Esc> :q<Cr>
endfunction

autocmd FileType lua setlocal commentstring=--\ %s

if has('mouse')
	set mouse=a
end

" Mappings {
	" Commenting
	nmap <leader>c gcc

	" Visual Commenting
	vmap <leader>c gc
	
	" NERDTree
	nmap <silent> <leader>n :NERDTreeToggle<cr>
	nmap <silent> <leader>m :NERDTreeFind<cr>
	
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

	nnoremap <C-p> :Unite file_rec/async<cr>
	nnoremap <C-[> :Unite -quick-match buffer<cr>
	" nnoremap <C-[> :CtrlPBuffer<CR>
	
	nunmap <Esc>
	
	inoremap <expr> <Tab> pumvisible() ? "<C-n>" : "<Tab>"
	inoremap <expr> <C-p> ((empty(&omnifunc) \|\| pumvisible()) ? "<C-n>" : "<C-x><C-o>")
	inoremap <expr> <C-n> ((empty(&omnifunc) \|\| pumvisible()) ? "<C-p>" : "<C-x><C-o>")
" }
