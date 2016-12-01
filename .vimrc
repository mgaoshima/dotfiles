"" vim-plug
call plug#begin()
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'StanAngeloff/php.vim'
"Plug 'alpaca-tc/beautify.vim'
Plug 'banyan/recognize_charcode.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'digitaltoad/vim-jade'
"Plug 'dsawardekar/wordpress.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'https://github.com/hail2u/vim-css3-syntax'
Plug 'kana/vim-fakeclip'
Plug 'mattn/emmet-vim'
Plug 'nixprime/cpsm'
Plug 'noahfrederick/vim-noctu'
Plug 'othree/html5.vim'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'pgdouyon/vim-evanesco'
Plug 'shawncplus/phpcomplete.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sleuth'
Plug 'airblade/vim-gitgutter'
Plug 'joshdick/onedark.vim'
call plug#end()

filetype plugin indent on
syntax enable

try
  colorscheme onedark
  highlight Normal ctermbg=NONE
  highlight Statusline ctermbg=NONE
  highlight SpecialKey ctermfg=236
catch
endtry
nohlsearch

"" settings
set ambiwidth=single
set autoindent
set autoread
set backspace=indent,eol,start
set backupdir=/tmp
set complete-=i
set directory=/tmp
set expandtab
set gdefault
set hidden
set history=1000
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set list
set listchars=tab:▸\ 
set mouse=a
set nowrap
set nrformats-=octal
set number
set ruler
set sessionoptions-=options
set shiftwidth=2
set smartcase
set smarttab
set softtabstop=2
set tabstop=2
set ttimeout
set ttimeoutlen=100
set viminfo^=!
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.jpg,*.png
set wildmenu
set wildmode=list:longest

"" Auto Complete - http://io-fia.blogspot.jp/2012/11/vimvimrc.html
set completeopt=menuone
for k in split("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_",'\zs')
  exec "imap " . k . " " . k . "<C-N><C-P>"
endfor
imap <expr> <TAB> pumvisible() ? "\<Down>" : "\<Tab>"

"" Keymap
let mapleader = "\<Space>"
nmap <C-h> :bp<CR>
nmap <C-l> :bn<CR>
nmap <silent><Esc><Esc> <Esc>:nohlsearch<CR>
nmap n nzz
nmap N Nzz
nmap j gj
nmap k gk
nmap <leader>w :w<CR>

autocmd BufRead * set ambiwidth=single

"" javascript-libraries-syntax.vim
let g:used_javascript_libs = 'jquery,handlebars'

"" ctrlp.vim
"let g:ctrlp_show_hidden = 1
"let g:ctrlp_working_path_mode = 'rwa'
"let g:ctrlp_custom_ignore = '\v[\/](node_modules|build|dist|wp-admin|wp-include|vendors)|\.(git|hg|svn|DS_Store)$'
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']



"" ============================================================================
""
"" Statusline - https://github.com/noahfrederick/dots/blob/master/vim/vimrc
""
"" ============================================================================

let &statusline  = '%6*%{exists("*ObsessionStatus")?ObsessionStatus(StatuslineProject(), StatuslineProject() . " (paused)"):""}'
let &statusline .= '%#StatusLineNC#%{exists("*ObsessionStatus")?ObsessionStatus("", "", StatuslineProject()):StatuslineProject()}'
let &statusline .= "%#StatusLineNC#%{StatuslineGit()}%*"
let &statusline .= "%* %f"
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
