set tabstop=4
set softtabstop=4
set expandtab
set shiftwidth=4
syntax enable
set background=dark
color desert
set tabpagemax=30
nnoremap <F3> :set invpaste paste?<CR>
set pastetoggle=<F3>
set showmode
set completeopt=menuone

#execute pathogen#infect()

filetype on            " enables filetype detection
filetype plugin on     " enables filetype specific plugins
"filetype plugin on
"
" line numbers:
set number

" Wild menu
set wildmenu
set wildmode=full

" Backspace behavior - default to only what was typed
set backspace=indent

" Make searches case-insensitive, unless they contain upper-case letters
set ignorecase
set smartcase

set autoindent
set history=1000 " keep 1000 lines of history
set ruler " show the cursor position
set incsearch
set hlsearch
set cc=80
hi ColorColumn ctermbg=blue

map <F2> :w<CR>
map! <F2> <Esc>:w<CR><i>
map <silent> <F4> :nohlsearch<CR>
"map <F5> :%s/\s\+$//g<CR>
map <F5> <C-w>gf
map <F6> :tabnew<CR>:e 
map <F7> :set invrelativenumber<CR>:e 
vmap <F3> :'<,'>s/^/#/g<CR>

set showtabline=2
map <C-z> :tabprevious<cr>
map <C-x> :tabnext<cr>
map <C-q> :tabclose<cr>
noremap <Space> i<Space><Esc>r

"augroup vimrc_autocmds
"  autocmd BufEnter * highlight OverLength cterm=reverse
"  autocmd BufEnter * match OverLength /\%80v.*/
"augroup END


"set viminfo='20,\"200 " keep a .viminfo file
"if has('syntax') && (&t_Co > 2)
"  syntax on
"endif

"if !exists("autocommands_loaded")
"  let autocommands_loaded = 1
"  autocmd BufRead,BufNewFile,FileReadPost *.py source ~/.vim/python
"endif

" This beauty remembers where you were the last time you edited the file, and returns to the same position.
"au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

"----------------------------------------------
" Enable commenting/uncommenting blocks of code
fun! IsComment()
  return synIDattr(synIDtrans(synID(line("."), col("."), 0)), "name") == "Comment"
endfun

fun! ToggleComment()
"  let curr_comment = IsComment()
  if IsComment()
    try 
      s/^\(\s*\)#/\1/
    catch /.*/
    endtry
  else
    s/^/#/
  endif
endfun
map <F8> :call ToggleComment()<CR>
"----------------------------------------------
