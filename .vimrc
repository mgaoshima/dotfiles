"" plugins
call plug#begin() " vim-plug
Plug 'tpope/vim-sensible'
Plug 'kana/vim-fakeclip'
Plug 'editorconfig/editorconfig-vim'
Plug 'pgdouyon/vim-evanesco'
Plug 'tpope/vim-sleuth'
"" auto paste/nopaste
Plug 'ConradIrwin/vim-bracketed-paste'
"" auto-detect fileencoding
Plug 'banyan/recognize_charcode.vim'
"" filer
Plug 'ctrlpvim/ctrlp.vim'
Plug 'nixprime/cpsm'
"" git
Plug 'tpope/vim-fugitive'
"" completion
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
"" colorscheme
Plug 'noahfrederick/vim-noctu'
Plug 'brendonrapp/smyck-vim'
Plug 'kristijanhusak/vim-hybrid-material'
"" html
Plug 'mattn/emmet-vim', { 'for': [ 'html', 'php' ] }
Plug 'othree/html5.vim'
"" css
Plug 'hail2u/vim-css3-syntax', { 'for': [ 'css', 'sass', 'scss' ] }
"" php
Plug 'nishigori/vim-php-dictionary', { 'for': 'php' }
Plug 'shawncplus/phpcomplete.vim', { 'for': 'php' }
Plug 'dsawardekar/wordpress.vim', { 'for': [ 'php', 'wordpress'] }
call plug#end()

"" colorscheme
colorscheme noctu

"" swap files
set directory=/tmp
set backupdir=/tmp

"" settings
set hidden
set number
set nowrap
set hlsearch

"" menu
set wildmenu
set wildmode=list:longest

"" mouse
set mouse=a

"" statusline
"" set statusline=\ #%n\ %<%f%m%r%q\ \ \ %c,%l%=
""   \%{strlen(&fenc)?&fenc:'empty'}\ %{&ff}\ %{tolower(&ft)}
""   \%{strlen(fugitive#statusline())?join(['\ ',fugitive#statusline()[5:][:-3]],'\ '):''}\ 

"" list
set list
set listchars=tab:▸\ 
highlight SpecialKey ctermfg=236

"" indent
set expandtab
set smarttab
set tabstop=2
set softtabstop=2
set shiftwidth=2 expandtab

"" search
set ignorecase
set smartcase
nohlsearch

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
let g:ctrlp_match_func = {'match': 'cpsm#CtrlPMatch'}

"" phpcomplete.vim
let g:php_sync_method = 1

"" YouCompleteMe
let g:ycm_autoclose_preview_window_after_insertion = 1  " Scratchバッファを自動で消す

"" Status line - https://github.com/noahfrederick/dots/blob/master/vim/vimrc
let &statusline  = '%6*%{exists("*ObsessionStatus")?ObsessionStatus(StatuslineProject(), StatuslineProject() . " (paused)"):""}'
let &statusline .= '%#StatusLineNC#%{exists("*ObsessionStatus")?ObsessionStatus("", "", StatuslineProject()):StatuslineProject()}'
let &statusline .= "%* %f"
let &statusline .= "%#StatusLineNC#%{StatuslineGit()}%* "
let &statusline .= '%1*%{&modified && !&readonly?"\*":""}%*'
let &statusline .= '%1*%{&modified && &readonly?"\*":""}%*'
let &statusline .= '%2*%{&modifiable?"":"\*"}%*'
let &statusline .= '%3*%{&readonly && &modifiable && !&modified?"\*":""}%*'
let &statusline .= "%="
let &statusline .= "%#StatusLineNC#%{StatuslineIndent()}%* "
let &statusline .= '%#StatuslineNC#%{(strlen(&fileencoding) && &fileencoding !=# &encoding)?&fileencoding." ":""}'
let &statusline .= '%{&fileformat!="unix"?" ".&fileformat." ":""}%*'
let &statusline .= '%{strlen(&filetype)?&filetype." ":""}'
let &statusline .= '%#Error#%{exists("*SyntasticStatuslineFlag")?SyntasticStatuslineFlag():""}'
let &statusline .= "%{StatuslineTrailingWhitespace()}%*"

function! StatuslineGit()
  if !exists('*fugitive#head')
    return ''
  endif
  let l:out = fugitive#head(8)
  if l:out !=# ''
    let l:out = ' @' . l:out
  endif
  return l:out
endfunction

function! StatuslineIndent()
  if !&modifiable
    return ''
  endif

  if &expandtab == 0 && &tabstop == 8
    " Sleuth.vim has detected mixed indentation
    return "!!"
  endif

  let l:symbol = &expandtab ? "\u2334" : "\u21E5"
  let l:amount = exists('*shiftwidth') ? shiftwidth() : &shiftwidth
  return &expandtab ? repeat(l:symbol, l:amount) : l:symbol
endfunction

function! StatuslineProject()
  return getcwd() == $HOME ? "~" : fnamemodify(getcwd(), ':t')
endfunction

function! StatuslineTrailingWhitespace()
  if !exists("b:statusline_trailing_whitespace")
    if !&modifiable || search('\s\+$', 'nw') == 0
      let b:statusline_trailing_whitespace = ""
    else
      let b:statusline_trailing_whitespace = "  \u2334 "
    endif
  endif

  return b:statusline_trailing_whitespace
endfunction

augroup vimrc_statusline
  autocmd!
  autocmd CursorHold,BufWritePost * unlet! b:statusline_trailing_whitespace
augroup END
