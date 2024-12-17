set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

" Specify a directory for plugins
" - For Neovim: 
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin(stdpath('data') . '/plugged')

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'WhoIsSethDaniel/mason-tool-installer.nvim'
Plug 'sainnhe/sonokai'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'majutsushi/tagbar'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'alvan/vim-closetag'
Plug 'preservim/nerdcommenter'
Plug 'psf/black'

call plug#end()

colo sonokai

" Make highlighting python in markdown fancy
let g:markdown_fenced_languages = ['python']

" Add tabbar at the top
let g:airline#extensions#tabline#enabled = 1

" Color scheme
hi MatchParen cterm=bold ctermbg=none ctermfg=green

set encoding=utf-8
set cpoptions+=$
set nowrap
set autoindent
set tabstop=4
set shiftwidth=4
set expandtab
set hlsearch
set incsearch
set ignorecase
set number
syntax enable

set hidden		" allow buffers with unsaved changes
set wildmenu	" expand vim commands like :tabe
set wildmode=full
set scrolloff=4	" keep 4 lines off the edges of the screen when scrolling
set noswapfile	" never used it
set nomodeline	" ignore vim modelines

" Give more space for displaying messages.
set cmdheight=2

" Set leader to ,
let mapleader=","

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

noremap gd <C-]>

" Fugitive bindings
nmap <silent> gb :Git blame<cr>

augroup Markdown
  autocmd!
  autocmd BufRead,BufNewFile *.mdx set filetype=markdown
  autocmd FileType markdown set linebreak wrap
augroup END

augroup black_on_save
  autocmd!
  autocmd BufWritePre *.py Black
augroup end

" fix workman binding
noremap l o
noremap o l
noremap L O
noremap O L
noremap j n
noremap n j
noremap J N
noremap N J
noremap k e
noremap e k
noremap K E
noremap E K
noremap h y
noremap y h
noremap H Y
noremap Y H

" remap surround plugin	
let g:surround_no_mappings = 1
nmap ds  <Plug>Dsurround
nmap cs  <Plug>Csurround
nmap cS  <Plug>CSurround
nmap hs  <Plug>Ysurround
nmap hS  <Plug>YSurround
nmap hss <Plug>Yssurround
nmap hSs <Plug>YSsurround
nmap hSS <Plug>YSsurround
xmap S   <Plug>VSurround
xmap gS  <Plug>VgSurround

" Remap FZF to ctrl p
nmap <C-P> :FZF<CR>

" Remap buffer close
map <C-x> :bd<CR>

" Remap buffer switching
map <C-o> :bn<CR>
map <C-y> :bp<CR>

" clear search results
vnoremap // y/<C-R>"<CR>"
" map <leader>/ to turn off search highlight
nnoremap <Leader>/ :noh<CR>

let g:bufferline_echo = 0

nmap <F8> :TagbarToggle<CR>
let g:tagbar_autoclose = 1
let g:tagbar_autofocus = 1

autocmd BufRead,BufNewFile *.md setlocal textwidth=80

lua << EOF
require('nvim-treesitter.configs').setup({
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "python", "typescript", "javascript", "svelte", "css" },
  sync_install = false,
  auto_install = false,

  highlight = {
    enable = true,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
})

require("mason").setup({ })
require("mason-tool-installer").setup({
    ensure_installed = {
        "prettier",
        "pyright",
        "svelte-language-server",
        "lua-language-server",
        "vim-language-server"
    }
})

require("mason-lspconfig").setup({})
require("lspconfig").svelte.setup({})
require("lspconfig").pyright.setup({})
EOF


