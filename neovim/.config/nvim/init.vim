"""""""""
" notes
"""""""""
"
" - migrate to lazy.vim
" - fix terrible lsp configs
" - notes on rustaceanvim
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


" for opening docs comments using :RustOpenExternalDocs
" https://github.com/neovim/neovim/issues/13675#issuecomment-885666975
" let g:nvim_tree_disable_netrw = 0
" let g:nvim_tree_hijack_netrw = 0

"lua <<EOF
"-- from nvim-tree/nvim-tree's github; suggests being up high in the config
"-- disable netrw at the very start of your init.lua (strongly advised)
"vim.g.loaded_netrw = 1
"vim.g.loaded_netrwPlugin = 1
"EOF

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
"let g:prettier#autoformat = 1
"let g:prettier#autoformat_require_pragma = 0
"let g:prettier#exec_cmd_async = 1

" rust
"let g:rustfmt_fail_silently = 0
"let g:rustfmt_options = 'overwrite'
"let g:rustfmt_autosave = 1

syntax enable
filetype plugin indent on

lua <<EOF
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
  'mrcjkb/rustaceanvim',
  version = '^4', -- Recommended
  ft = { 'rust' },
})
EOF

call plug#begin()
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.x' }
Plug 'neovim/nvim-lspconfig'

" completion framework
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

" For vsnip users.
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

Plug 'nvim-lua/lsp_extensions.nvim'
Plug 'nvim-lua/completion-nvim'
" remove these when the tf lsp is a bit better (or my config is better)
Plug 'hashivim/vim-terraform'
Plug 'vim-syntastic/syntastic'
Plug 'juliosueiras/vim-terraform-completion'
"Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'tpope/vim-fugitive'
" for file icons
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'airblade/vim-gitgutter'
Plug 'dracula/vim', { 'as': 'dracula' }
" \m/ deafheaven
Plug 'nikolvs/vim-sunbather'
Plug 'jparise/vim-graphql'
Plug 'folke/tokyonight.nvim'
call plug#end()

colorscheme dracula
"set background=light
"colorscheme sunbather
"colorscheme tokyonight-day
"colorscheme tokyonight-moon

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

lua <<EOF
  -- Set up nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Set up lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  require('lspconfig')['tsserver'].setup {
    capabilities = capabilities
  }
  require('lspconfig')['terraformls'].setup {
    capabilities = capabilities
  }
  require('lspconfig')['lua_ls'].setup {
    capabilities = capabilities
  }
  require('lspconfig')['nixd'].setup {
    capabilities = capabilities
  }
EOF


lua <<EOF
-- :h nvim-tree-setup
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    width = 30,
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
nnoremap <leader>gd :RustOpenExternalDocs<cr>

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

" directional navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" tabs
nnoremap <silent>    <C-N> <cmd>tabprevious<CR>
nnoremap <silent>    <C-M> <cmd>tabnext<CR>


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
    autocmd BufWritePre *.rs lua vim.lsp.buf.format()
augroup END

