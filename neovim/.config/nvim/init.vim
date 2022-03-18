" holy shit, this is so nice
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" use :options for full list
set tabstop=4 softtabstop=4 " might be removable with `filetype plugin indent on`
set shiftwidth=4
set expandtab
set smartindent
set exrc " project-local init.vim|lua
set relativenumber
set nu
set hidden " keep buffers around with open files
set noerrorbells
set smartcase
set ignorecase
set noswapfile
set undodir=~/vim/undodir
set undofile " probably need undo-tree
set incsearch
set scrolloff=8
set signcolumn=yes
set completeopt=menuone,noinsert,noselect
set updatetime=300
set clipboard+=unnamedplus

" vim-terraform config: https://github.com/hashivim/vim-terraform
let g:terraform_align=1
let g:terraform_fmt_on_save=1

" https://github.com/juliosueiras/vim-terraform-completion#vim-plug
" Syntastic Config
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" prettier
" to bypass, use :noautocmd w
let g:prettier#autoformat = 1
let g:prettier#autoformat_require_pragma = 0
let g:prettier#exec_cmd_async = 1

syntax enable
filetype plugin indent on

call plug#begin()
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
Plug 'nvim-treesitter/playground'
Plug 'neovim/nvim-lspconfig'

" rust tooling
Plug 'simrat39/rust-tools.nvim'
"" debugging
Plug 'nvim-lua/plenary.nvim'
Plug 'mfussenegger/nvim-dap'

Plug 'nvim-lua/lsp_extensions.nvim'
Plug 'nvim-lua/completion-nvim'
"Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
" remove these when the tf lsp is a bit better (or my config is better)
Plug 'hashivim/vim-terraform'
Plug 'vim-syntastic/syntastic'
Plug 'juliosueiras/vim-terraform-completion'
" https://github.com/prettier/vim-prettier
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'tpope/vim-fugitive'
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'
Plug 'airblade/vim-gitgutter'
Plug 'dracula/vim', { 'as': 'dracula' }
" \m/ deafheaven
Plug 'nikolvs/vim-sunbather'
call plug#end()

colorscheme dracula
"set background=light
"colorscheme sunbather

highlight! link SignColumn LineNr
let mapleader = " "

lua require'lspconfig'.tsserver.setup{}
lua require'rust-tools'.setup{}
lua require'lspconfig'.terraformls.setup{}
lua require'lspconfig'.rnix.setup{}
lua require'lspconfig'.sumneko_lua.setup{}
lua require'nvim-tree'.setup {}
lua require'nvim-web-devicons'.setup {}

" https://github.com/nvim-telescope/telescope.nvim
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>gg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>hh <cmd>lua require('telescope.builtin').grep_string()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>gs <cmd>lua require('telescope.builtin').git_status()<cr>
" nnoremap <leader>gc <cmd>lua require(ctelescope.builtin').<cr>

nnoremap <silent>K  <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent>gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent>gb <cmd>b#<CR>
nnoremap <silent>gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <leader>cc <cmd>cclose<CR>
nnoremap <leader>e <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>


nnoremap <C-o> :NvimTreeToggle<CR>

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" open splits to the right and below
" other useful stuff: https://thoughtbot.com/blog/vim-splits-move-faster-and-more-naturally
set splitbelow
set splitright

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

augroup DEFAULT_GROUP
    " clears out all cmds associated with this group on sourcing file making
    " sure multiple of the same listeners aren't attached
    autocmd!
    autocmd BufWritePre * :call TrimWhitespace()
    "autocmd CursorHold * lua vim.lsp.util.show_line_diagnostics()
    autocmd BufWritePre *.rs lua vim.lsp.buf.formatting_sync(nil, 200)
augroup END

