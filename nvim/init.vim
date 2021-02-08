syntax on
map <SPACE> <leader>

set number
set mouse=a
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set smartcase
set ignorecase
set scrolloff=10
set tabstop=4 shiftwidth=4 expandtab
set foldmethod=indent
set nofoldenable
set clipboard+=unnamedplus
set hidden
set nowrap
set nohlsearch
set incsearch
set colorcolumn=80

highlight ColorColumn ctermbg=0 guibg=#000000
highlight Pmenu ctermbg=15 guibg=black
highlight LineNr term=bold cterm=NONE ctermfg=black ctermbg=NONE gui=NONE guifg=black guibg=NONE

call plug#begin('~/.vim/plugged')

    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'tpope/vim-surround'
    Plug 'honza/vim-snippets'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-commentary'
    Plug 'jiangmiao/auto-pairs'
    Plug 'prettier/vim-prettier', {
        \ 'do': 'yarn install',
        \ 'for': ['python','javascript', 'css', 'scss', 'json', 'markdown', 'php', 'yaml', 'html'] }

    " Files
    Plug 'preservim/nerdtree'
    Plug 'majutsushi/tagbar'
    Plug 'itchyny/lightline.vim'

    " C++
    Plug 'octol/vim-cpp-enhanced-highlight'

    " Markdown
    Plug 'godlygeek/tabular'
    Plug 'plasticboy/vim-markdown'

    " Syntax checker
    Plug 'scrooloose/syntastic'

    " Interactive scratchpad
    Plug 'metakirby5/codi.vim'

    " Telescope
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'neovim/nvim-lspconfig'

    " Neovim lsp Plugins
    Plug 'neovim/nvim-lspconfig'
    Plug 'nvim-lua/completion-nvim'
    Plug 'tjdevries/nlua.nvim'
    Plug 'tjdevries/lsp_extensions.nvim'

    " Others
    Plug 'mhinz/vim-startify'

call plug#end()

let g:lightline = {
      \ 'colorscheme': 'simpleblack',
      \ }

" Syntastic options
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Prettier
let g:prettier#autoformat = 0
nmap <Leader>i <Plug>(Prettier)

" fzf
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }
command! -bang ProjectFiles call fzf#vim#files('~/workspace', <bang>0)

" Find files using Telescope command-line sugar.
nnoremap <leader>f :CocSearch -S
nnoremap <leader>l :Lines<CR>
nnoremap <leader><SPACE> <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>b  <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" LSP
set completeopt=menuone,noinsert,noselect
nnoremap <leader>vd :lua vim.lsp.buf.definition()<CR>

let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
lua require'lspconfig'.tsserver.setup{ on_attach=require'completion'.on_attach }
lua require'lspconfig'.clangd.setup{ on_attach=require'completion'.on_attach }
lua require'lspconfig'.pyls.setup{ on_attach=require'completion'.on_attach }
lua require'lspconfig'.gopls.setup{ on_attach=require'completion'.on_attach }
lua require'lspconfig'.rust_analyzer.setup{ on_attach=require'completion'.on_attach }
" lua require'nvim_lsp'.sumneko_lua.setup{ on_attach=require'completion'.on_attach }

" General
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>c :call CocAction('pickColor')<CR>
nnoremap <leader>n :tabnew<CR>
nnoremap <leader>. :bn<CR>
nnoremap <leader>, :bp<CR>
vnoremap <leader>p "_dP
nnoremap <leader>y "+y
nnoremap <leader>Y gg"+yG

" NerdTree
map <C-n> :NERDTreeToggle<CR>

" Tagbar
nmap <C-m> :TagbarToggle<CR>

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

augroup main
    autocmd!
    autocmd BufWritePre * :call TrimWhitespace()
    autocmd BufEnter,BufWinEnter,TabEnter *.rs :lua require'lsp_extensions'.inlay_hints{}
augroup END
