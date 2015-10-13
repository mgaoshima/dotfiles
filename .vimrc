"" plugins
call plug#begin() " vim-plug
Plug 'tpope/vim-sensible'
Plug 'kana/vim-fakeclip'
Plug 'editorconfig/editorconfig-vim'
"" auto paste/nopaste
Plug 'ConradIrwin/vim-bracketed-paste'
"" auto-detect fileencoding
Plug 'banyan/recognize_charcode.vim'
"" filer
Plug 'ctrlpvim/ctrlp.vim'
"" completion
Plug 'Shougo/neocomplete.vim'
"" git
Plug 'tpope/vim-fugitive'
"" colorscheme
Plug 'brendonrapp/smyck-vim'
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'nanotech/jellybeans.vim'
"" html
Plug 'mattn/emmet-vim'
Plug 'othree/html5.vim'
"" css
Plug 'hail2u/vim-css3-syntax'
"" php
Plug 'nishigori/vim-php-dictionary'
call plug#end()

"" colorscheme
colorscheme hybrid_material

"" swap files
set directory=/tmp
set backupdir=/tmp

"" settings
set number
set nowrap
set hlsearch
nohlsearch

"" menu
set wildmenu
set wildmode=list:longest

"" mouse
set mouse=a

"" statusline
set statusline=\ #%n\ %<%f%m%r%q\ \ \ %c,%l%=
  \%{strlen(&fenc)?&fenc:'empty'}\ %{&ff}\ %{tolower(&ft)}
  \%{strlen(fugitive#statusline())?join(['\ ',fugitive#statusline()[5:][:-3]],'\ '):''}\ 

"" list
set list
set listchars=tab:▸\ 

"" indent
set expandtab
set smarttab
set tabstop=2
set softtabstop=2
set shiftwidth=2 expandtab

"" search
set ignorecase
set smartcase

"" keymap
let mapleader = "\<Space>"
nmap <C-h> :bp<CR>
nmap <C-l> :bn<CR>
nmap <Leader>w :w<CR>
nmap <silent><Esc><Esc> <Esc>:nohlsearch<CR>
nmap N Nzz
nmap j gj
nmap k gk
nmap n nzz

"" ctrlp.vim
let g:ctrlp_show_hidden = 1
let g:ctrlp_working_path_mode = 'a'
let g:ctrlp_extensions = ['tag', 'quickfix', 'dir', 'line', 'mixed']
let g:ctrlp_custom_ignore = '\v[\/](node_modules|dist)|(\.(git|svn|ico|icns|png|jpg|jpeg|DS_Store))$'

"" neocomplete.vim
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
