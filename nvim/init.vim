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
highlight Pmenu ctermfg=15 ctermbg=0 guifg=#ffffff guibg=#000000
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE

call plug#begin('~/.vim/plugged')
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'tpope/vim-surround'
    Plug 'junegunn/fzf.vim'
    Plug 'honza/vim-snippets'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-commentary'
    Plug 'jiangmiao/auto-pairs'
    Plug 'preservim/nerdtree'
    Plug 'majutsushi/tagbar'
    Plug 'itchyny/lightline.vim'

    "C# Development
    Plug 'OmniSharp/omnisharp-vim'

    " Markdown
    Plug 'godlygeek/tabular'
    Plug 'plasticboy/vim-markdown'

    " Syntax checker
    Plug 'scrooloose/syntastic'

    Plug 'metakirby5/codi.vim'

    " Telescope
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'neovim/nvim-lspconfig'

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

set list lcs=tab:\|\

let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }

command! -bang ProjectFiles call fzf#vim#files('~/workspace', <bang>0)

" Search
nnoremap <leader><SPACE> :Files<CR>
nnoremap <leader>o :ProjectFiles<CR>
nnoremap <leader>f :CocSearch -S
nnoremap <leader>l :Lines<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>r :Tags<CR>
nnoremap <leader>m :Marks<CR>
nmap <leader><tab> <plug>(fzf-maps-n)

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" General
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>c :call CocAction('pickColor')<CR>
nnoremap <leader>n :tabnew<CR>
nnoremap <leader>. :bn<CR>
nnoremap <leader>, :bp<CR>

" NerdTree
map <C-n> :NERDTreeToggle<CR>

" Tagbar
nmap <C-m> :TagbarToggle<CR>

autocmd CursorHold * silent call CocActionAsync('highlight')
nmap <leader>i  <Plug>(coc-format)

inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

augroup main
    autocmd!
    autocmd BufWritePre * :call TrimWhitespace()
augroup END
