if $SHELL =~ 'fish'
  set shell=/bin/bash
endif

if has('vim_starting')
  set nocompatible
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'tpope/vim-surround'
NeoBundle 'kana/vim-fakeclip.git'
NeoBundle 'othree/html5.vim.git'
NeoBundle 'hail2u/vim-css3-syntax.git'
NeoBundle 'fatih/vim-go'
NeoBundle 'plasticboy/vim-markdown'
NeoBundle 'gcavallanti/vim-noscrollbar'
NeoBundle 'editorconfig/editorconfig-vim'
NeoBundle 'vim-scripts/BusyBee'
NeoBundle '29decibel/codeschool-vim-theme'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'ctrlpvim/ctrlp.vim'
NeoBundle 'mileszs/ack.vim'
call neobundle#end()
filetype plugin indent on
NeoBundleCheck


syntax enable
colorscheme BusyBee
set notitle ttyfast hidden
set directory=/tmp backupdir=/tmp
set backspace=indent,eol,start
set number ruler nowrap
set wildmenu wildmode=list:longest
set laststatus=2
set statusline=b%n\ %f%m%r%=%L\ %y[%{&ff},%{&fenc}]\ %{noscrollbar#statusline(15,'-','#')}
set cindent autoindent smartindent
set expandtab smarttab tabstop=2 softtabstop=2 shiftwidth=2 et
set ignorecase smartcase
set wrapscan hlsearch incsearch gdefault
set list listchars=tab:▸\ 

"" gvim
if has('gui_running')
  colorscheme codeschool
  set guioptions=
  set visualbell t_vb=
  set guifont=Menlo:h14
  set linespace=3
  set transparency=2
endif


"" keymap
nmap j gj
nmap k gk
nmap n nzz
nmap N Nzz
nmap <C-h> :bp<CR>
nmap <C-l> :bn<CR>
nmap <C-j> 10jzz
nmap <C-k> 10kzz
imap <C-j> <Esc>
map <Esc><Esc> <Esc>:noh<CR>


"" VimGrep時にcwindowを開く
autocmd QuickFixCmdPost *grep* cwindow

"" NerdTree
nnoremap <silent><C-e> :NERDTreeToggle<CR>

"" emmet-vim
let g:user_emmet_settings = { 'lang' : 'ja' }

"" vim-markdown
let g:vim_markdown_folding_disabled=1

"" git-status整形
nnoremap <Leader>k :%s;\([AMD]\)\t\(.*\);\t/\2\t\1;ge<CR>:%s;\t\(.*\.php\t\);\1\t;ge<CR>:%s;\t\(.*\.html\t\);\1\t;ge<CR>:%s;\tM;\t変更;ge<CR>:%s;\tA;\t新規;ge<CR>:%s;\tD;\t削除;ge<CR>


" 文字コードの自動認識
if &encoding !=# 'utf-8'
  set encoding=japan
  set fileencoding=japan
endif
if has('iconv')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'
  " iconvがeucJP-msに対応しているかをチェック
  if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'eucjp-ms'
    let s:enc_jis = 'iso-2022-jp-3'
  " iconvがJISX0213に対応しているかをチェック
  elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213'
    let s:enc_jis = 'iso-2022-jp-3'
  endif
  " fileencodingsを構築
  if &encoding ==# 'utf-8'
    let s:fileencodings_default = &fileencodings
    let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
    let &fileencodings = &fileencodings .','. s:fileencodings_default
    unlet s:fileencodings_default
  else
    let &fileencodings = &fileencodings .','. s:enc_jis
    set fileencodings+=utf-8,ucs-2le,ucs-2
    if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
      set fileencodings+=cp932
      set fileencodings-=euc-jp
      set fileencodings-=euc-jisx0213
      set fileencodings-=eucjp-ms
      let &encoding = s:enc_euc
      let &fileencoding = s:enc_euc
    else
      let &fileencodings = &fileencodings .','. s:enc_euc
    endif
  endif
  " 定数を処分
  unlet s:enc_euc
  unlet s:enc_jis
endif
" 日本語を含まない場合は fileencoding に encoding を使うようにする
if has('autocmd')
  function! AU_ReCheck_FENC()
    if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
      let &fileencoding=&encoding
    endif
  endfunction
  autocmd BufReadPost * call AU_ReCheck_FENC()
endif
" 改行コードの自動認識
set fileformats=unix,dos,mac
" □ とか○ の文字があってもカーソル位置がずれないようにする
if exists('&ambiwidth')
  set ambiwidth=double
endif
