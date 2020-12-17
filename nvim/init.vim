syntax on
map <SPACE> <leader>

set number
set mouse=a
set undodir=~/.vim/undodir
set undofile
set smartcase
set ignorecase
set scrolloff=10
set tabstop=4 shiftwidth=4 expandtab
set foldmethod=indent
set nofoldenable
set clipboard+=unnamedplus

set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=#111111
highlight Pmenu ctermfg=15 ctermbg=0 guifg=#ffffff guibg=#000000
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE

" TODO: add blink
set guicursor=n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20

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
call plug#end()

let g:lightline = {
      \ 'colorscheme': 'simpleblack',
      \ }

" NerdTree
map <C-n> :NERDTreeToggle<CR>

" Tagbar
nmap <C-m> :TagbarToggle<CR>

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

let $FZF_DEFAULT_OPTS='--reverse --color=dark --color=fg:-1,bg:-1,hl:#c678dd,fg+:#ffffff,bg+:#4b5263,hl+:#d858fe --color=info:#98c379,prompt:#61afef,pointer:#be5046,marker:#e5c07b,spinner:#61afef,header:#61afef'

command! -bang ProjectFiles call fzf#vim#files('~/workspace', <bang>0)
nnoremap <leader><SPACE> :Files<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>o :ProjectFiles<CR>
nnoremap <leader>f :CocSearch -S
nnoremap <leader>l :Lines<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>r :Tags<CR>
nnoremap <leader>g :Gcd<CR>
nnoremap <leader>s :G<CR>
nnoremap <leader>e :CocCommand explorer<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>p :vsplit<CR> \| :terminal git push<CR>i
nnoremap <leader>n :tabnew<CR>
nnoremap <leader>c :call CocAction('pickColor')<CR>
nnoremap <leader>h :GitGutterPreviewHunk<CR>
nnoremap <leader>m :Marks<CR>
nnoremap <leader>k :call <SID>show_documentation()<CR>
nnoremap <leader>. :bn<CR>
nnoremap <leader>, :bp<CR>

nmap <leader><tab> <plug>(fzf-maps-n)

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
