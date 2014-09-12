"
" Look mom! This is my .vimrc!
"
syntax on

if has("gui_running")
    " Remember window positions and sizes (gVim)
    set sessionoptions+=resize,winpos
    autocmd VIMEnter * :source ~/.vim/.session.vim
    autocmd VIMLeave * :mksession! ~/.vim/.session.vim

    if has("gui_win32")
        " Set font for gVim
        set guifont=MeiryoKe_Console:h9
    elseif has("gui_gtk2")
        set guifont=Monospace\ 9
    elseif has("gui_macvim")
        set guifont=Menlo\ Regular:h12
    endif
endif

" Cursor
"highlight Cursor guifg=black guibg=black
"highlight iCursor guifg=black guibg=black
"set guicursor=n-v-c:block-Cursor
"set guicursor+=i:ver100-iCursor
"set guicursor+=n-v-c:blinkon0
"set guicursor+=i:blinkwait10

"" Folding
set foldlevelstart=99           " Don't fold anything when opening a new file

"" Backup and undo settings
set backupdir=~/.vim/  " backup//   " location of backups
set directory=~/.vim/  " swp//      " location of swap files
set undofile
set undodir=~/.vim/    " undo//
set undolevels=9000             " maximum number of changes that can be undone
set undoreload=9000             " maximum number lines to save for undo on a
                                " buffer reload

" Enable spell checking
setlocal spell spelllang=en_us
autocmd FileType * setlocal spell spelllang=en_us
highlight clear SpellBad
highlight SpellBad cterm=underline

" Auto completion
set complete+=kspell

" Open a new file without saving a current file
set hidden

" Show guideline and highlight characters exceeding 80 characters
highlight OverLength ctermbg=yellow ctermfg=yellow guibg=black
match OverLength /\%81v.\+/

if exists('+colorcolumn')
    set colorcolumn=80
else
    au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

" Do not enable IME on Windows
set iminsert=0
set imsearch=-1

" Remove end of line spaces when file is saved
autocmd BufWritePre * :%s/\s\+$//ge

" Automatically change the current directory
set autochdir

" No word wrapping
set nowrap

" Allow moving between lines with right and left moving.
set whichwrap=b,s,<,>,[,]

set encoding=utf-8
set fileencodings=utf-8,cp932,euc-jp,iso-2022-jp,ucs-2,latin1
set fileformats=unix,dos,mac

" Formatting
set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4

set ruler
set title
set statusline=%<[%n]%F%=\ %m%r%h%w%y%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}\ %l,%c\ %P

" Do not make backup files.
set nobackup

" Indent
set autoindent
set smartindent

" Search setting
set ignorecase " Ignore case when the target string is only small letter.
set smartcase  " Treats case when the target string contains upper case.

" Auto completion
set wildmenu

" Highlights parenthesis
set showmatch

" Always show the status line
set laststatus=2

" Use a mouse
set mouse=a
set ttymouse=xterm2

" Use an incremental search
set incsearch

" Smart backspace
set backspace=indent,eol,start

" Show line numbers
set number

" Show invisible characters
set list
set listchars=tab:>-,trail:.,extends:>,precedes:<,nbsp:.

set showmode
set cursorline

" Show Zenkaku-space
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=#666666
au BufNewFile,BufRead * match ZenkakuSpace /　/

" Close current buffer without closing the window
command Bd bp | sp | bn | bd

" ----------------------------------------------
" NeoBundle Scripts-----------------------------
"
if has('vim_starting')
    "set nocompatible               " Be iMproved

    " Required:
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'flazz/vim-colorschemes'
NeoBundle 'Shougo/neocomplete'

" You can specify revision/branch/tag.
NeoBundle 'Shougo/vimshell', { 'rev' : '3787e5' }

" Required:
call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck
"
" End NeoBundle Scripts-------------------------
" ----------------------------------------------

" --------------------------------------------------------------------------
" NeoComplate Settings
"
" Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
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

"
" The end of NeoComplete settings
" ----------------------------------------------------------------------------

