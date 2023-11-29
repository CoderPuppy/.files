" vim-plug {
	call plug#begin('~/.local/share/nvim/site/plugged')

	" Plugins {
		Plug 'tpope/vim-repeat' " library for `.` support
		Plug 'tpope/vim-unimpaired' " paired operations: swap lines ([e, ]e)
		Plug 'tpope/vim-surround' " surroundings (quotes, parens, etc…)
		" Disabled because I usually don't look at the linenumbers so I can just
		" use relativenumber
		" Plug 'jeffkreeftmeijer/vim-numbertoggle'
		" Plug 'tpope/vim-fugitive' " Git support
		Plug 'tomtom/tlib_vim'
		Plug 'tomtom/tcomment_vim' " commenting
		Plug 'Shougo/denite.nvim' " fuzzy find for everything
		Plug 'mg979/vim-visual-multi' " multiple cursors
		Plug 'yamafaktory/lumberjack.vim' " colorscheme
		Plug 'danro/rename.vim' " rename open files
		" Plug 'scrooloose/syntastic' " live error checking
		Plug 'dense-analysis/ale' " live error checking
		" Plug 'simnalamburt/vim-mundo' " undo tree
		Plug 'mbbill/undotree' " undo tree
		Plug 'godlygeek/tabular' " alignment
		" Plug 'junegunn/vim-easy-align' " alignment
		Plug 'CoderPuppy/vim-diff-fold' " folding for diffs
		" Plug 'floobits/floobits-neovim' " realtime collaboration
		Plug 'Shougo/vimproc.vim', {'do': 'make'}
		Plug 'jpalardy/vim-slime'
		Plug 'rhysd/vim-grammarous' " grammar checker
		Plug 'neovim/nvim-lspconfig'
		Plug 'kyazdani42/nvim-web-devicons' " icons for nvim-tree
		Plug 'kyazdani42/nvim-tree.lua' " file tree
		Plug 'nvim-treesitter/nvim-treesitter', { 'branch': '0.5-compat' }
		Plug 'lukas-reineke/indent-blankline.nvim' " indent levels
		Plug 'kana/vim-textobj-user'
		Plug 'neovimhaskell/nvim-hs.vim'

		Plug 'hrsh7th/nvim-cmp' " completion
		Plug 'hrsh7th/cmp-buffer'
		Plug 'hrsh7th/cmp-nvim-lsp'

		Plug 'elixir-lang/vim-elixir'
		Plug 'vim-scripts/nxc.vim'
		Plug 'derekwyatt/vim-scala'
		Plug 'rust-lang/rust.vim'
		Plug 'JuliaLang/julia-vim'
		Plug 'lambdatoast/elm.vim'
		Plug 'raichoo/purescript-vim'
		" Plug 'idris-hackers/idris-vim'
		Plug 'edwinb/idris2-vim'
		Plug 'weakish/rcshell.vim'
		Plug 'cespare/vim-toml'
		Plug 'wavded/vim-stylus'
		" Plug 'derekelkins/agda-vim'
		Plug 'isovector/cornelis'
		Plug 'wlangstroth/vim-racket'
		Plug 'vito-c/jq.vim'
		Plug 'fsharp/vim-fsharp', {
			\ 'for': 'fsharp',
			\ 'do': 'mark fsautocomplete',
			\}
		Plug 'HerringtonDarkholme/yats.vim'
		Plug 'gkz/vim-ls'
		Plug 'jez/vim-better-sml'
		Plug 'ziglang/zig.vim'
		Plug 'tfnico/vim-gradle'
		Plug 'dylon/vim-antlr'
		Plug 'tikhomirov/vim-glsl'
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
set incsearch
set listchars=tab:>\ ,trail:-,nbsp:+,eol:↴,space:␣

set exrc secure

if has('mouse')
	set mouse=a
end

set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" Colorscheme
" set termguicolors
syntax on
colorscheme lumberjack
hi LineNr ctermfg=darkgrey

" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0

let g:ale_linters = {}
let g:ale_linters.haskell = ['hdevtools']
let g:ale_haskell_hdevtools_options = '-g -Wall -g -Wredundant-constraints -g -Wno-tabs -g -Wno-name-shadowing -g -Wno-type-defaults'
let g:ale_linters.python = ['mypy', 'pylint']

call denite#custom#var('file/rec', 'command', ['ag', '--hidden', '-g', '', '--nocolor', '--noaffinity'])
call denite#custom#source('file/rec', 'matchers', ['matcher/fuzzy'])
call denite#custom#source('file/rec', 'sorters', ['sorter/rank'])
call denite#custom#var('grep', 'command', ['ag'])
call denite#custom#var('grep', 'default_opts', ['--smart-case', '--noaffinity', '--vimgrep'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', [])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])
command! Ag Denite grep
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
	nnoremap <silent><buffer><expr> i denite#do_map('open_filter_buffer')
	nnoremap <silent><buffer><expr> <CR> denite#do_map('do_action')
	nnoremap <silent><buffer><expr> <Esc> denite#do_map('quit')
	nnoremap <silent><buffer><expr> <F5> denite#do_map('redraw')
endfunction
autocmd FileType denite-filter call s:denite_filter_my_settings()
function! s:denite_filter_my_settings() abort
	inoremap <silent><buffer><expr> <CR> denite#do_map('do_action')
	imap <silent><buffer> <Esc> <Plug>(denite_filter_quit)
endfunction

lua << EOF
	require 'lspconfig'.ocamllsp.setup {}
	require 'lspconfig'.hls.setup {}
	require 'lspconfig'.rust_analyzer.setup {}

	local cmp = require'cmp'
	cmp.setup({
		mapping = {
			['<C-y>'] = cmp.mapping.confirm({ select = true }),
		},
		sources = {
			{ name = 'buffer' },
			{ name = 'nvim_lsp' },
		}
	})

	-- TODO: advertise cmp-nvim-lsp capabilities

	require('indent_blankline').setup {
		enabled = false;
		char = '│';
		buftype_exclude = {'terminal'};
		space_char_blankline = ' ';
		show_end_of_line = true;
	}

	require 'nvim-tree'.setup {
	}
EOF

autocmd FileType lua setlocal commentstring=--\ %s
autocmd BufNewFile,BufRead *.ti setlocal filetype=lua
autocmd BufNewFile,BufRead *.slua setlocal filetype=lua
autocmd FileType sml setlocal tabstop=3 softtabstop=3 shiftwidth=3 textwidth=0

" load Merlin for OCaml if available
if executable('opam')
	let g:opamshare=substitute(system('opam config var share'),'\n$','','''')
	if isdirectory(g:opamshare."/merlin/vim")
		execute "set rtp+=" . g:opamshare . "/merlin/vim"
		execute "helptags " . g:opamshare . "/merlin/vim/doc"
	endif
endif

let g:idris_allow_tabchar = 1

let g:rust_recommended_style = 0

autocmd BufNewFile,BufRead *.lagda.md set filetype=agda.markdown
autocmd FileType agda call AgdaFileType()
function! AgdaFileType()
	setlocal expandtab
	nnoremap <buffer> <localleader>l :w<CR>:CornelisLoad<CR>
	nnoremap <buffer> <localleader>r :CornelisRefine<CR>
	nnoremap <buffer> <localleader>c :CornelisMakeCase<CR>
	nnoremap <buffer> <localleader>e :CornelisTypeContext<CR>
	nnoremap <buffer> <localleader>E :CornelisTypeContextInfer<CR>
	nnoremap <buffer> <localleader>m :CornelisGoals<CR>
	nnoremap <buffer> <localleader>n :CornelisNormalize<CR>
	nnoremap <buffer> <localleader>s :CornelisSolve<CR>
	nnoremap <buffer> <localleader>a :CornelisAuto<CR>
	nnoremap <buffer> <localleader>q :CornelisQuestionToMeta<CR>
	nnoremap <buffer> gd        :CornelisGoToDefinition<CR>
	nnoremap <buffer> [/        :CornelisPrevGoal<CR>
	nnoremap <buffer> ]/        :CornelisNextGoal<CR>
endfunction

" Mappings {
	" Commenting
	nmap <leader>c gcc
	vmap <leader>c gc

	" nvim-tree
	nnoremap <silent> <leader>n :NvimTreeToggle<cr>
	nnoremap <silent> <leader>m :NvimTreeFindFile<cr>

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

	cnoremap <expr> <Tab>   getcmdtype() == "/" \|\| getcmdtype() == "?"
		\ ? "<CR>/<C-r>/" : "<C-z>"
	cnoremap <expr> <S-Tab> getcmdtype() == "/" \|\| getcmdtype() == "?"
		\ ? "<CR>?<C-r>/" : "<S-Tab>"

	nnoremap <C-p> :Denite -start-filter file/rec<cr>
	" nnoremap <C-[> :Denite buffer<cr>

	nunmap <Esc>

	" completion stuff?
	inoremap <expr> <Tab> pumvisible() ? "<C-n>" : "<Tab>"
	inoremap <expr> <C-p> ((empty(&omnifunc) \|\| pumvisible()) ? "<C-n>" : "<C-x><C-o>")
	inoremap <expr> <C-n> ((empty(&omnifunc) \|\| pumvisible()) ? "<C-p>" : "<C-x><C-o>")
" }
