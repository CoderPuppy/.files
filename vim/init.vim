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
		Plug 'Shougo/denite.nvim'
		Plug 'gkz/vim-ls'
		Plug 'terryma/vim-multiple-cursors'
		Plug 'yamafaktory/lumberjack.vim'
		Plug 'danro/rename.vim'
		Plug 'Lokaltog/vim-easymotion'
		Plug 'tfnico/vim-gradle'
		" Plug 'rking/ag.vim'
		Plug 'mileszs/ack.vim'
		" Plug 'scrooloose/syntastic'
		Plug 'w0rp/ale'
		" Plug 'simnalamburt/vim-mundo'
		Plug 'mbbill/undotree'
		Plug 'godlygeek/tabular'
		Plug 'junegunn/vim-easy-align'
		Plug 'CoderPuppy/vim-diff-fold'
		Plug 'floobits/floobits-neovim'
		Plug 'Shougo/vimproc.vim', {'do': 'make'}
		Plug 'jpalardy/vim-slime'
		Plug 'Shougo/deoplete.nvim'
		Plug 'rhysd/vim-grammarous'

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
		Plug 'wavded/vim-stylus'
		Plug 'derekelkins/agda-vim'
		Plug 'wlangstroth/vim-racket'
		Plug 'vito-c/jq.vim'
		Plug 'fsharp/vim-fsharp', {
			\ 'for': 'fsharp',
			\ 'do': 'mark fsautocomplete',
			\}
		Plug 'HerringtonDarkholme/yats.vim'

		" Haskell
		" Plug 'eagletmt/ghcmod-vim'
		Plug 'eagletmt/neco-ghc'
	" }
	
	call plug#end()
" }

let g:python_host_prog='/usr/bin/python2'
let g:python3_host_prog='/usr/bin/python3'
let mapleader = ','
let maplocalleader = "\\"
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
" set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0

let g:ale_linters = {}
let g:ale_linters.haskell = ['hdevtools']
let g:ale_haskell_hdevtools_options = '-g -Wall -g -Wredundant-constraints -g -Wno-tabs -g -Wno-name-shadowing -g -Wno-type-defaults'

autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

set completeopt=longest,menuone
let g:deoplete#enable_at_startup = 1
let g:deoplete#disable_auto_complete = 1

let g:ackrg = 'ag --vimgrep --noaffinity --smart-case'
cnoreabbrev Ag Ack
cnoreabbrev ag Ack

call denite#custom#var('file/rec', 'command', ['ag', '--hidden', '-g', '', '--nocolor', '--noaffinity'])
call denite#custom#source('file/rec', 'matchers', ['matcher/fuzzy'])
call denite#custom#source('file/rec', 'sorters', ['sorter/rank'])
call denite#custom#map('normal', 'k', '<denite:move_to_next_line>', 'noremap')
call denite#custom#map('normal', 'l', '<denite:move_to_previous_line>', 'noremap')
call denite#custom#map('insert', '<Esc>', '<denite:enter_mode:normal>', 'noremap')
call denite#custom#map('normal', '<Esc>', '<denite:quit>', 'noremap')
call denite#custom#map('insert', '<Down>', '<denite:move_to_next_line>', 'noremap')
call denite#custom#map('insert', '<Up>', '<denite:move_to_previous_line>', 'noremap')
call denite#custom#map('_', '<F5>', '<denite:redraw>', 'noremap')

let g:idris_allow_tabchar = 1

autocmd FileType lua setlocal commentstring=--\ %s
autocmd BufNewFile,BufRead *.ti set filetype=lua
autocmd BufNewFile,BufRead *.slua set filetype=lua

set exrc secure

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

	" Undotree
	nmap <silent> <leader>u :UndotreeToggle<cr>
	
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

	nnoremap <C-p> :Denite file/rec<cr>
	nnoremap <C-[> :Denite -quick-match buffer<cr>
	" nnoremap <C-[> :CtrlPBuffer<CR>
	
	nunmap <Esc>
	
	inoremap <expr> <Tab> pumvisible() ? "<C-n>" : "<Tab>"
	inoremap <expr> <C-p> ((empty(&omnifunc) \|\| pumvisible()) ? "<C-n>" : "<C-x><C-o>")
	inoremap <expr> <C-n> ((empty(&omnifunc) \|\| pumvisible()) ? "<C-p>" : "<C-x><C-o>")
" }
