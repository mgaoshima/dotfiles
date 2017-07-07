"" vim-plug
call plug#begin()

  " utility ---------------------
  Plug 'kana/vim-fakeclip'
  Plug 'ConradIrwin/vim-bracketed-paste'
  Plug 'banyan/recognize_charcode.vim'
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'mattn/emmet-vim'
  Plug 'pgdouyon/vim-evanesco'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'cocopon/vaffle.vim'

  " git -------------------------
  Plug 'tpope/vim-fugitive'
  Plug 'airblade/vim-gitgutter'

  " syntax ----------------------
  Plug 'othree/html5.vim'
  Plug 'hail2u/vim-css3-syntax'
  Plug 'jason0x43/vim-js-indent'
  Plug 'leafgarland/typescript-vim'
    Plug 'Shougo/vimproc.vim', {'do' : 'make'}
    Plug 'Quramy/tsuquyomi'
  Plug 'StanAngeloff/php.vim'
  Plug 'digitaltoad/vim-pug'
  Plug 'othree/yajs.vim'
  Plug 'othree/javascript-libraries-syntax.vim'
    let g:used_javascript_libs = 'jquery,underscore,backbone,react,handlebars,vue'
  Plug 'othree/es.next.syntax.vim'
  Plug 'maxmellon/vim-jsx-pretty'
    let g:vim_jsx_pretty_colorful_config = 1

  " colorscheme -----------------
  Plug 'joshdick/onedark.vim'
  Plug 'noahfrederick/vim-noctu'
  Plug 'cocopon/iceberg.vim'

  " lint ------------------------
  Plug 'w0rp/ale'

call plug#end()

filetype plugin indent on
syntax enable

try
  "colorscheme onedark
  "highlight Normal ctermbg=NONE
  "highlight Statusline ctermbg=NONE
  "highlight SpecialKey ctermfg=236
  colorscheme iceberg
catch
endtry


"" settings
set title
set hidden
set confirm
set nofixeol
set directory=/tmp
set backupdir=/tmp
set history=200
set mouse=a
set backspace=indent,eol,start
set number
set ruler
set cursorline
set laststatus=2
set nowrap
set ignorecase
set smartcase
set gdefault
set incsearch
set hlsearch
set wrapscan
set nrformats=
set autoindent
set smartindent
set smarttab
set expandtab
set tabstop=2
set shiftwidth=2
set list listchars=tab:▸\ "
set wildmode=list:longest,full
set wildignore=*/tmp/*,*.so,*.swp,*.bak,*.min.*,*.map,*.jpg,*.png,*.gif
set pumheight=10

autocmd BufRead * set ambiwidth=single

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
noremap m %

"" ctrlp.vim
let g:ctrlp_show_hidden = 1
let g:ctrlp_custom_ignore = '\v[\/](node_modules|build|dist|wp-admin|wp-include|vendors)|\.(git|hg|svn|DS_Store)$'

"" ale.vim
let g:ale_linters = {
      \   'html': [],
      \}
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

"" ============================================================================
""
"" Statusline - https://github.com/noahfrederick/dots/blob/master/vim/vimrc#L195-L263
""
"" ============================================================================

let &statusline  = '%6*%{exists("*ObsessionStatus")?ObsessionStatus(StatuslineProject(), StatuslineProject() . " (paused)"):""}'
let &statusline .= '%#StatusLineNC#%{exists("*ObsessionStatus")?ObsessionStatus("", "", StatuslineProject()):StatuslineProject()}'
let &statusline .= "%#StatusLineNC#%{StatuslineGit()}%*"
let &statusline .= "%* %f "
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
