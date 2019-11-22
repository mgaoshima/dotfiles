"" vim-plug
call plug#begin()

  " utility ---------------------
  Plug 'kana/vim-fakeclip'
  Plug 'ConradIrwin/vim-bracketed-paste'
  Plug 'banyan/recognize_charcode.vim'
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'mattn/emmet-vim'
  Plug 'nzmosh/statusline-vim'

  " git -------------------------
  Plug 'tpope/vim-fugitive'
  Plug 'airblade/vim-gitgutter'

  " syntax ----------------------
  Plug 'othree/html5.vim'
  Plug 'hail2u/vim-css3-syntax'
  Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx', 'html'] }
  Plug 'othree/yajs.vim', { 'for': ['javascript', 'javascript.jsx', 'html'] }
  Plug 'othree/es.next.syntax.vim', { 'for': ['javascript', 'javascript.jsx'] }
  Plug 'maxmellon/vim-jsx-pretty', { 'for': ['javascript', 'javascript.jsx'] }

  " colorscheme -----------------
  Plug 'cocopon/iceberg.vim'
  Plug 'arcticicestudio/nord-vim'

call plug#end()

filetype plugin indent on
syntax enable

"colorscheme iceberg
colorscheme nord
hi Visual term=reverse cterm=reverse guibg=Grey

"" settings
set title hidden confirm noeol nofixeol directory=/tmp backupdir=/tmp history=200
set mouse=a backspace=indent,eol,start number ruler nocursorline nowrap
set ignorecase smartcase gdefault incsearch hlsearch wrapscan
set autoindent smartindent smarttab expandtab tabstop=2 shiftwidth=2
set list listchars=tab:▸\ "
set wildmode=list:longest,full
set wildignore=*/tmp/*,*.so,*.swp,*.bak,*.min.*,*.map,*.jpg,*.png,*.gif
set laststatus=2 pumheight=10
set nrformats=
set cursorline

autocmd BufRead * set ambiwidth=single

autocmd BufNewFile,BufRead *.inc  set filetype=html

"" Auto Complete - http://io-fia.blogspot.jp/2012/11/vimvimrc.html
set completeopt=menuone
for k in split("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_",'\zs')
  exec "imap " . k . " " . k . "<C-N><C-P>"
endfor
imap <expr> <TAB> pumvisible() ? "\<Down>" : "\<Tab>"

"" Keymap
noremap <C-h> :bp<CR>
noremap <C-l> :bn<CR>
noremap j gj
noremap k gk
noremap @sp o@include sp {<CR>}<ESC>O
noremap @pc o@include pc {<CR>}<ESC>O
""vmap dv2 ygvs<C-r>=<C-r>0/2<ESC><ESC>

noremap @blank i<span class="icon-blank" aria-label="新しいタブで開きます"></span><esc>

"" ctrlp.vim
let g:ctrlp_show_hidden = 1
let g:ctrlp_custom_ignore = '\v[\/](node_modules|build|dist|wp-admin|wp-include|vendors)|\.(git|hg|svn|DS_Store)$'