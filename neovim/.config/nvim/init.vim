"""""""""
" notes
"""""""""
"
" - (05/18/22) rust-tools's inlay hints aren't working as expected, and a feat rewrite
"   is in progress for it
"       - https://github.com/simrat39/rust-tools.nvim/issues/163
"
"""""""""


"""""""""
" resources
"
" - rust ide setup (todo debugger)
"       - https://sharksforarms.dev/posts/neovim-rust/
"
"""""""""


" holy shit, this is so nice
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


lua <<EOF
-- from nvim-tree/nvim-tree's github; suggests being up high in the config
-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
EOF

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

" rust
"let g:rustfmt_fail_silently = 0
"let g:rustfmt_options = 'overwrite'
"let g:rustfmt_autosave = 1

syntax enable
filetype plugin indent on

call plug#begin()
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
"Plug 'nvim-treesitter/playground'
Plug 'neovim/nvim-lspconfig'
" completion framework
Plug 'hrsh7th/nvim-cmp'
" LSP completion source for nvim-cmp
Plug 'hrsh7th/cmp-nvim-lsp'
" snippet completion source for nvim-cmp
Plug 'hrsh7th/cmp-vsnip'
" other useful completion sources
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-buffer'
" enables more of the features of rust-analyzer
Plug 'simrat39/rust-tools.nvim'
" snippet engine
Plug 'hrsh7th/vim-vsnip'
Plug 'nvim-lua/lsp_extensions.nvim'
Plug 'nvim-lua/completion-nvim'
" remove these when the tf lsp is a bit better (or my config is better)
Plug 'hashivim/vim-terraform'
Plug 'vim-syntastic/syntastic'
Plug 'juliosueiras/vim-terraform-completion'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'tpope/vim-fugitive'
" for file icons
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'airblade/vim-gitgutter'
Plug 'dracula/vim', { 'as': 'dracula' }
" \m/ deafheaven
Plug 'nikolvs/vim-sunbather'
Plug 'jparise/vim-graphql'
call plug#end()

colorscheme dracula
"set background=light
"colorscheme sunbather

highlight! link SignColumn LineNr
let mapleader = " "

" Set completeopt to have a better completion experience
" :help completeopt
" menuone: popup even when there's only one match
" noinsert: Do not insert text until a selection is made
" noselect: Do not select, force user to select one from the menu
set completeopt=menuone,noinsert,noselect

" Avoid showing extra messages when using completion
set shortmess+=c

" folding
set foldmethod=manual
set foldexpr=nvim_treesitter#foldexpr()
" disable folding at startup
set nofoldenable

" Configure LSP through rust-tools.nvim plugin.
" rust-tools will configure and enable certain LSP features for us.
" See https://github.com/simrat39/rust-tools.nvim#configuration

lua <<EOF
local nvim_lsp = require'lspconfig'

local rust_opts = {
    tools = { -- rust-tools options
        autoSetHints = true,
        --hover_with_actions = true,
        inlay_hints = {
            only_current_line = false,
            show_parameter_hints = false,
            parameter_hints_prefix = "",
            other_hints_prefix = "",
        },
    },

    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
    server = {
        -- on_attach is a callback called when the language server attachs to the buffer
        -- on_attach = on_attach,
        settings = {
            -- to enable rust-analyzer settings visit:
            -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
            ["rust-analyzer"] = {
                -- enable clippy on save
                checkOnSave = {
                    command = "clippy"
                },
            }
        }
    },
}

require('rust-tools').setup(rust_opts)

EOF

" Setup Completion
" See https://github.com/hrsh7th/nvim-cmp#basic-configuration
lua <<EOF
local cmp = require'cmp'
cmp.setup({
  -- Enable LSP snippets
  snippet = {
    expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    -- Add tab support
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },

  -- Installed sources
  sources = {
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'path' },
    { name = 'buffer' },
  },
})
EOF

lua require'lspconfig'.tsserver.setup{}
lua require'lspconfig'.terraformls.setup{}
lua require'lspconfig'.sumneko_lua.setup{}
lua require'nvim-web-devicons'.setup {}

lua <<EOF
-- :h nvim-tree-setup
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    width = 30,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
    relativenumber = false,
  },
  renderer = {
    group_empty = true,
    -- on macOS I have some trouble with the nvim-tree icons that I (years later) haven't figured out
    icons = {
      glyphs = {
        default = "",
        symlink = "",
        bookmark = "",
        modified = "●",
        folder = {
          arrow_closed = "",
          arrow_open = "",
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
          symlink_open = "",
        },
      }
    }
  },
  filters = {
    dotfiles = false,
  },
  auto_reload_on_write = true,
})
EOF

lua <<EOF
require('telescope').setup{
  defaults = {
    mappings = {
      n = {
    	  ['<c-d>'] = require('telescope.actions').delete_buffer
      },
      i = {
        ["<C-h>"] = "which_key",
        ['<c-d>'] = require('telescope.actions').delete_buffer
      }
    }
  },
}
EOF

" https://github.com/nvim-telescope/telescope.nvim
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>gg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>hh <cmd>lua require('telescope.builtin').grep_string()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers({sort_lastused})<cr>
nnoremap <leader>gs <cmd>lua require('telescope.builtin').git_status()<cr>
" nnoremap <leader>gc <cmd>lua require(ctelescope.builtin').<cr>

nnoremap <silent>K      <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent>gd     <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent>ga     <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <silent>gb     <cmd>b#<CR>
nnoremap <silent>gr     <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <leader>cc     <cmd>cclose<CR>
nnoremap <leader>e      <cmd>lua vim.diagnostic.open_float()<CR>
nnoremap <leader>fh     <cmd>lua require('telescope.builtin').help_tags()<cr>

" `esc` to act normally in :term
tnoremap <Esc> <C-\><C-n>

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
    autocmd BufWritePre *.rs lua vim.lsp.buf.formatting_sync(nil, 300)
augroup END

