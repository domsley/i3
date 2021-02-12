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
" set nowrap
set incsearch
set colorcolumn=80
set termguicolors
set noshowmode
set noruler
set laststatus=0
set noshowcmd
set cmdheight=1

call plug#begin('~/.vim/plugged')

    " Vim is now smart !
    Plug 'neoclide/coc.nvim', {'branch': 'release'}

    " Finder
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'kyazdani42/nvim-web-devicons'

    " Files
    Plug 'preservim/nerdtree'
    Plug 'majutsushi/tagbar'

    " C++
    Plug 'octol/vim-cpp-enhanced-highlight'

    " Markdown
    Plug 'godlygeek/tabular'
    Plug 'plasticboy/vim-markdown'

    " Interactive scratchpad
    Plug 'metakirby5/codi.vim'

    " Syntax checker
    Plug 'scrooloose/syntastic'

    " Others
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-commentary'
    Plug 'jiangmiao/auto-pairs'
    Plug 'mhinz/vim-startify'
    Plug 'itchyny/lightline.vim'
    Plug 'lucasprag/simpleblack'

call plug#end()

" COLORS
colorscheme simpleblack

" CoC
let g:coc_global_extensions = [
    \ 'coc-json',
    \ 'coc-python',
    \ 'coc-phpls',
    \ 'coc-prettier',
    \ 'coc-discord',
    \ 'coc-omnisharp',
    \ 'coc-clangd',
    \ 'coc-html',
    \ 'coc-tailwindcss',
    \ 'coc-snippets',
    \ 'coc-xml',
    \ 'coc-vimlsp',
    \ 'coc-yaml',
    \ 'coc-git']

" StatusLine
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

" fzf
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }
command! -bang ProjectFiles call fzf#vim#files('~/workspace', <bang>0)

" Find files using Telescope command-line sugar.
nnoremap <leader><SPACE> <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>b  <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" General
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>c :call CocAction('pickColor')<CR>
nnoremap <leader>n :tabnew<CR>
nnoremap <leader>. :bn<CR>
nnoremap <leader>, :bp<CR>

" Copy Paste
vnoremap <leader>p "_dP
nnoremap <leader>y "+y
nnoremap <leader>Y gg"+yG

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nnoremap <leader>f :CocSearch -S

" Jumping between windows in vim
map <leader>h :wincmd h<CR>
map <leader>j :wincmd j<CR>
map <leader>k :wincmd k<CR>
map <leader>l :wincmd l<CR>

" remap esc
inoremap jk <esc>

" NerdTree
map <C-n> :NERDTreeToggle<CR>

" Tagbar
nmap <C-m> :TagbarToggle<CR>

":Prettier
command! -nargs=0 Prettier :CocCommand prettier.formatFile

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

augroup main
    autocmd!
    autocmd BufWritePre * :call TrimWhitespace()
augroup END
