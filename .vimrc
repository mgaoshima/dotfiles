if has('vim_starting')
  set nocompatible
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'

" colorschemes
NeoBundle '29decibel/codeschool-vim-theme'
NeoBundle 'brendonrapp/smyck-vim'
NeoBundle 'goatslacker/mango.vim'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'kristijanhusak/vim-hybrid-material'

" helpers
NeoBundle 'kana/vim-fakeclip.git'
NeoBundle 'ConradIrwin/vim-bracketed-paste'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'mgaoshima/editorconfig-vim'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'cohama/agit.vim'
NeoBundle 'digitaltoad/vim-jade'

" dictionaries
NeoBundle 'hail2u/vim-css3-syntax.git'
NeoBundle 'miya0001/vim-dict-wordpress'
NeoBundle 'othree/html5.vim.git'

" auto-detect fileencoding
NeoBundle 'banyan/recognize_charcode.vim'

" neocomplete
NeoBundle 'Shougo/neocomplete.vim'
  "Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
  " Disable AutoComplPop.
  let g:acp_enableAtStartup = 0
  " Use neocomplete.
  let g:neocomplete#enable_at_startup = 1
  " Use smartcase.
  let g:neocomplete#enable_smart_case = 1
  " Set minimum syntax keyword length.
  let g:neocomplete#sources#syntax#min_keyword_length = 3
  let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

  " Define dictionary.
  let g:neocomplete#sources#dictionary#dictionaries = {
      \ 'default' : '',
      \ 'vimshell' : $HOME.'/.vimshell_hist',
      \ 'scheme' : $HOME.'/.gosh_completions'
          \ }

  " Define keyword.
  if !exists('g:neocomplete#keyword_patterns')
      let g:neocomplete#keyword_patterns = {}
  endif
  let g:neocomplete#keyword_patterns['default'] = '\h\w*'

  " Plugin key-mappings.
  inoremap <expr><C-g>     neocomplete#undo_completion()
  inoremap <expr><C-l>     neocomplete#complete_common_string()

  " Recommended key-mappings.
  " <CR>: close popup and save indent.
  inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
  function! s:my_cr_function()
    return neocomplete#close_popup() . "\<CR>"
    " For no inserting <CR> key.
    "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
  endfunction
  " <TAB>: completion.
  inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
  " <C-h>, <BS>: close popup and delete backword char.
  inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
  inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
  inoremap <expr><C-y>  neocomplete#close_popup()
  inoremap <expr><C-e>  neocomplete#cancel_popup()
  " Close popup by <Space>.
  "inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

  " For cursor moving in insert mode(Not recommended)
  "inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
  "inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
  "inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
  "inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"
  " Or set this.
  "let g:neocomplete#enable_cursor_hold_i = 1
  " Or set this.
  "let g:neocomplete#enable_insert_char_pre = 1

  " AutoComplPop like behavior.
  "let g:neocomplete#enable_auto_select = 1

  " Shell like behavior(not recommended).
  "set completeopt+=longest
  "let g:neocomplete#enable_auto_select = 1
  "let g:neocomplete#disable_auto_complete = 1
  "inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

  " Enable omni completion.
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

  " Enable heavy omni completion.
  if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
  endif
  "let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
  "let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
  "let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

  " For perlomni.vim setting.
  " https://github.com/c9s/perlomni.vim
  let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'


" vim-go
NeoBundle 'fatih/vim-go'
  let g:go_highlight_functions = 1
  let g:go_highlight_methods = 1
  let g:go_highlight_structs = 1
  let g:go_highlight_operators = 1
  let g:go_highlight_build_constraints = 1
  au FileType go nmap <leader>r <Plug>(go-run)
  au FileType go nmap <leader>b <Plug>(go-build)
  au FileType go nmap <leader>t <Plug>(go-test)
  au FileType go nmap <leader>c <Plug>(go-coverage)
  let g:go_fmt_command = "goimports"

call neobundle#end()
filetype plugin indent on
NeoBundleCheck


set notitle ttyfast hidden
set directory=/tmp backupdir=/tmp
set backspace=indent,eol,start
set number ruler nowrap
set wildmenu wildmode=list:longest
set laststatus=2
set statusline=\ #%n\ %<%f%m%r%q\ \ \ %c,%l%=
      \%{strlen(&fenc)?&fenc:'empty'}\ %{&ff}\ %{tolower(&ft)}
      \%{strlen(fugitive#statusline())?join(['\ ',fugitive#statusline()[5:][:-3]],'\ '):''}\ 
set cindent autoindent smartindent
set expandtab smarttab tabstop=2 softtabstop=2 shiftwidth=2 et
set ignorecase smartcase
set wrapscan hlsearch incsearch gdefault
set list listchars=tab:▸\ 
set shortmess+=I
set mouse=a


"" keymap
let mapleader = "\<Space>"
nmap j gj
nmap k gk
nmap n nzz
nmap N Nzz
nmap <C-h> :bp<CR>
nmap <C-l> :bn<CR>
map <Esc><Esc> <Esc>:noh<CR>
nnoremap <Leader>o :CtrlP<CR>
nnoremap <Leader>w :w<CR>
nnoremap <Leader>g :Agit<CR>


"" VimGrep時にcwindowを開く
autocmd QuickFixCmdPost *grep* cwindow


syntax enable
colorscheme hybrid_material


"" gvim
if has('gui_running')
  if has('mac')
    "" Mac
    colorscheme jellybeans
    set guioptions=
    set visualbell t_vb=
    set guifont=Menlo:h14
    set linespace=2
    set transparency=8
  else
    if has('unix')
      "" Unix
      colorscheme torte
      set guioptions=
      set visualbell t_vb=
      set guifont=Ubuntu\ Mono\ h12
      set linespace=2
    else
      "" Windows
    endif
  endif
endif


"" Override highlight
hi Normal                                        ctermbg=NONE
hi NonText                                       ctermbg=NONE
hi LineNr                            ctermfg=242 ctermbg=NONE guifg=#555555 guibg=NONE
hi StatusLine   term=NONE cterm=NONE ctermfg=258 ctermbg=233  guifg=#e9e9e9 guibg=#333333 gui=NONE
hi StatusLineNC term=NONE cterm=NONE ctermfg=246 ctermbg=233  guifg=#777777 guibg=#333333 gui=NONE
hi VertSplit    term=NONE cterm=NONE ctermfg=242 ctermbg=NONE guifg=#555555 guibg=NONE
hi SpecialKey   term=NONE cterm=NONE ctermfg=240 ctermbg=NONE guifg=#555555 guibg=NONE
