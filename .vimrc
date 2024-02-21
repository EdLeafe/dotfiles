set nocompatible

" plugins
let need_to_install_plugins = 0
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    "autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    let need_to_install_plugins = 1
endif

call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
Plug 'yegappan/mru'
"Plug 'itchyny/lightline.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'psf/black', { 'branch': 'stable' }
Plug 'mhinz/vim-signify'
Plug 'majutsushi/tagbar'
Plug 'lepture/vim-jinja'
Plug 'pangloss/vim-javascript'
Plug 'vim-scripts/ScrollColors'
Plug 'metakirby5/codi.vim'
Plug 'luochen1990/rainbow'
Plug 'wellle/context.vim'
Plug 'ctrlpvim/ctrlp.vim'       " A fuzzy file finder
Plug 'nathanaelkane/vim-indent-guides'
Plug 'wfxr/minimap.vim'
Plug 'sheerun/vim-polyglot'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'fisadev/vim-isort'
" Colorschemes
Plug 'vv9k/bogster'
Plug 'pineapplegiant/spaceduck', { 'branch': 'main' }
Plug 'bcat/abbott.vim'
Plug 'https://gitlab.com/yorickpeterse/vim-paper.git'
Plug 'dracula/vim'
Plug 'arcticicestudio/nord-vim'
Plug 'joshdick/onedark.vim'
Plug 'josegamez82/starrynight'
Plug 'wojciechkepka/vim-github-dark'
Plug 'vim-scripts/lettuce.vim'
Plug 'jlanzarotta/bufexplorer'
Plug 'sjl/gundo.vim'
" Not used
"Plug 'itchyny/calendar.vim'
"Plug 'junegunn/goyo.vim'
"Plug 'ap/vim-buftabline'
"Plug 'airblade/vim-gitgutter'
"Plug 'vim-scripts/The-NERD-tree'
"Plug 'jistr/vim-nerdtree-tabs'
"Plug 'Xuyuanp/nerdtree-git-plugin'
"Plug 'scrooloose/syntastic'
call plug#end()

filetype plugin indent on
syntax on
set noreadonly

if need_to_install_plugins == 1
    echo "Installing plugins..."
    silent! PlugInstall
    echo "Done!"
    q
endif

" always show the status bar
set laststatus=2

" enable 256 colors
set t_Co=256
set t_ut=

" turn on line numbering
set number

" Wild menu
set wildmenu
set wildmode=full
set wildignore+=*/.git/*,*/tmp/*,*.swp,*.swo

let g:ctrlp_map = '<c-n>'
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_working_path_mode = 'ra'
"
" gundo
let g:gundo_prefer_python3 = 1

" Use Ripgrep for file finder
if executable('rg')
    set grepprg=rg\ --color=never
    let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
    let g:ctrlp_use_caching = 0
endif

" guard for distributions lacking the persistent_undo feature.
if has('persistent_undo')
    " define a path to store persistent_undo files.
    let target_path = expand('~/.config/vim-persisted-undo/')

    " create the directory and any parent directories
    " if the location does not exist.
    if !isdirectory(target_path)
        call system('mkdir -p ' . target_path)
    endif

    " point Vim to the defined undo directory.
    let &undodir = target_path

    " finally, enable undo persistence.
    set undofile
endif

" Make searches case-insensitive, unless they contain upper-case letters
set ignorecase
set smartcase

" sane text files
set fileformat=unix
set encoding=utf-8
set fileencoding=utf-8

" turn on spelling check
set spell spelllang=en_us
set nospell

" Use softer github colors
let g:gh_color = "soft"

" sane editing
set colorcolumn=120
hi ColorColumn ctermbg=blue
set viminfo='25,\"50,n~/.viminfo
set tabstop=4
set softtabstop=4
set expandtab
set shiftwidth=4
set textwidth=120
syntax enable
set background=dark
"color koehler
colorscheme nord
set tabpagemax=30
set backspace=indent,eol,start
nnoremap <F3> :set invpaste paste?<CR>

set pastetoggle=<F3>
set showmode
set foldmethod=indent
set nofoldenable
set diffopt=vertical
" For MacVim
set gfn=Monaco:h14

" word movement
imap <S-Left> <Esc>bi
nmap <S-Left> b
imap <S-Right> <Esc><Right>wi
nmap <S-Right> w

" indent/unindent with tab/shift-tab
nmap <Tab> >>
imap <S-Tab> <Esc><<i
nmap <S-tab> <<

" Toggle soft wrap
nmap <Leader>W :set wrap! linebreak textwidth=0<CR>
" Sort Python imports
vnoremap <Leader>S :'<,'>sort r / .*/<CR>
" Format code with Black
nnoremap <Leader>B :Black<CR>
nnoremap <Leader>bb :Black<CR>

set wildcharm=<Tab>
nnoremap <Leader><Tab> :buffer<Space><Tab>

nnoremap <F1> :w<CR>
nnoremap <C-F1> :help<CR>
"nnoremap <F2> :help<CR>
map <F2> :w<CR>
map!<F2> <Esc>:w<CR><i>
"nmap W :w!<CR>
nmap <silent> <F4> :nohlsearch<CR>
nmap <C-F5> :%s/\s\+$//g<CR>
nmap <F5> <C-w>gFzz
nmap <F6> :tabnew<CR>:e 
nmap <C-F6> :tabnew<CR>:e<Space>ngccli/
vmap <F8> :'<,'>s/^/#/g<CR>

"Keep lines centered
nnoremap n nzz
nnoremap N Nzz


" Sessions
nnoremap <leader>ss :mksession! ~/.vim/sessions/
nnoremap <leader>sl :source ~/.vim/sessions/


set showtabline=2
nmap <C-z> :tabprevious<cr>
nmap <C-x> <Nop>
nmap <C-c> :tabnext<cr>
"map <C-w> :tabclose<cr>
"noremap <Space> i<Space><Esc>r
nnoremap <Leader>z :suspend<CR>

" mouse
set mouse=a
let g:is_mouse_enabled = 1
noremap <silent> <Leader>m :call ToggleMouse()<CR>
function ToggleMouse()
    if g:is_mouse_enabled == 1
        echo "Mouse OFF"
        set mouse=
        let g:is_mouse_enabled = 0
    else
        echo "Mouse ON"
        set mouse=a
        let g:is_mouse_enabled = 1
    endif
endfunction

function! VisualSelection()
    if mode()=="v"
        let [line_start, column_start] = getpos("v")[1:2]
        let [line_end, column_end] = getpos(".")[1:2]
    else
        let [line_start, column_start] = getpos("'<")[1:2]
        let [line_end, column_end] = getpos("'>")[1:2]
    end
    if (line2byte(line_start)+column_start) > (line2byte(line_end)+column_end)
        let [line_start, column_start, line_end, column_end] =
        \   [line_end, column_end, line_start, column_start]
    end
    let lines = getline(line_start, line_end)
    if len(lines) == 0
            return ''
    endif
    let lines[-1] = lines[-1][: column_end - 1]
    let lines[0] = lines[0][column_start - 1:]
    return join(lines, "\n")
endfunction


function ImportSortVal(ln)
  let sorted = ""
  let wds = split(ln, "[ \.]")
  for wd in wds
    if wd != "from" and wd != "import"
      sorted = sorted + wd
    endif
  endfor
  return sorted
endfunction

function ImportCompare(i1, i2)
    let score1 = ImportSortVal(i1)
    let score2 = ImportSortVal(i2)
    return score1 == score2 ? 0 : score1 > score2 ? 1 : -1
endfunction


" File browsing
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 20
nmap <Leader>VV :Vexplore<cr>
nmap <Leader>ll :Lexplore<cr>
"augroup ProjectDrawer
"  autocmd!
"  autocmd VimEnter * if argc() == 0 | Vexplore | endif
"augroup END


" MRU
let MRU_Window_Open_Always = 0
let MRU_Window_Height = 15
let MRU_Auto_Close = 1
let MRU_Open_File_Use_Tabs = 1

"function ToggleWrap()
"    if g:

syntax on
filetype on
filetype plugin indent on

" lightline
set noshowmode

set autoindent
set history=1000 " keep 1000 lines of history
set ruler " show the cursor position
set incsearch
set hlsearch

" code folding
set foldmethod=indent
set nofoldenable
set foldlevel=99

" wrap toggle
setlocal nowrap
noremap <silent> <Leader>w :call ToggleWrap()<CR>
function ToggleWrap()
    if &wrap
        echo "Wrap OFF"
        setlocal nowrap
        set virtualedit=all
        silent! nunmap <buffer> <Up>
        silent! nunmap <buffer> <Down>
        silent! nunmap <buffer> <Home>
        silent! nunmap <buffer> <End>
        silent! iunmap <buffer> <Up>
        silent! iunmap <buffer> <Down>
        silent! iunmap <buffer> <Home>
        silent! iunmap <buffer> <End>
    else
        echo "Wrap ON"
        setlocal wrap linebreak nolist
        set virtualedit=
        setlocal display+=lastline
        noremap  <buffer> <silent> <Up>   gk
        noremap  <buffer> <silent> <Down> gj
        noremap  <buffer> <silent> <Home> g<Home>
        noremap  <buffer> <silent> <End>  g<End>
        inoremap <buffer> <silent> <Up>   <C-o>gk
        inoremap <buffer> <silent> <Down> <C-o>gj
        inoremap <buffer> <silent> <Home> <C-o>g<Home>
        inoremap <buffer> <silent> <End>  <C-o>g<End>
    endif
endfunction

" Rainbow Parentheses
let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle

" move through split windows
nmap <leader><Up> :wincmd k<CR>
nmap <leader><Down> :wincmd j<CR>
nmap <leader><Left> :wincmd h<CR>
nmap <leader><Right> :wincmd l<CR>

" move through buffers
nmap <leader>[ :bp!<CR>
nmap <leader>] :bn!<CR>
nmap <leader>x :bd<CR>

" restore place in file from previous session
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" tag list
map <leader>t :TagbarToggle<CR>

" copy, cut and paste
vmap <C-c> "+y
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
imap <C-v> <ESC>"+pa
vmap <M-c> "+y
vmap <M-x> "+c
vmap <M-v> c<ESC>"+p
imap <M-v> <ESC>"+pa

" quit
nmap <Leader><Del> ZQ

" disable autoindent when pasting text
" source: https://coderwall.com/p/if9mda/automatically-set-paste-mode-in-vim-when-pasting-in-insert-mode
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"

function! XTermPasteBegin()
    set pastetoggle=<Esc>[201~
    set paste
    return ""
endfunction

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()
"noremap <Space> :

" allow pandoc to read different file types
autocmd BufReadPost *.doc,*.docx,*.rtf,*.odp,*.odt silent %!pandoc "%" -tplain -o /dev/stdout

" FZF
map <Leader>F :Files<CR>
map <Leader>G :GFiles<CR>
map <Leader>R :Rg<CR>
map <C-f> :Files<CR>
map <C-g> :GFiles<CR>

" syntastic
let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
map <leader>s :SyntasticCheck<CR>
map <leader>d :SyntasticReset<CR>
map <leader>e :lnext<CR>
map <leader>r :lprev<CR>

nnoremap <F7> :set relativenumber!<CR>
"----------------------------------------------
" Enable commenting/uncommenting blocks of code
fun! IsComment()
  return synIDattr(synIDtrans(synID(line("."), col("."), 0)), "name") == "Comment"
endfun

fun! ToggleComment()
"  let curr_comment = IsComment()
  if IsComment()
    try
      s/^# //
    catch /.*/
    endtry
  else
    s/^/# /
  endif
endfun
map <F8> :call ToggleComment()<CR>
"----------------------------------------------

" Wrap visual selection in an HTML tag.
vmap <Leader>w <Esc>:call VisualHTMLTagWrap()<CR>
fun! VisualHTMLTagWrap()
  let tag = input("Tag to wrap block: ")
  if len(tag) > 0
    normal `>
    if &selection == 'exclusive'
      exe "normal i</".tag.">"
    else
      exe "normal a</".tag.">"
    endif
    normal `<
    exe "normal i<".tag.">"
    normal `<
  endif
endfunc

" Wrap visual selection in any character
vmap <Leader>r <Esc>:call VisualBlockWrap()<CR>
fun! VisualBlockWrap()
  let char = input("Character(s) to wrap block: ")
  if len(char) > 0
    normal `>
    if &selection == 'exclusive'
      exe "normal i".char
    else
      exe "normal a".char
    endif
    normal `<
    exe "normal i".char
    normal `<
  endif
endfunc

" Wrap visual selection in quotes.
vmap <Leader>q <Esc>:call VisualQuotes()<CR>
fun! VisualQuotes()
  normal `>
  if &selection == 'exclusive'
    exe 'normal i"'
  else
    exe 'normal a"'
  endif
  normal `<
  exe 'normal i"'
  normal `<
endfunc

xnoremap <Leader>" di""<Esc>P
xnoremap <Leader>" di""<Esc>P
xnoremap <Leader>' di''<Esc>P
xnoremap <Leader>' di''<Esc>P
xnoremap <Leader>( di()<Esc>P
xnoremap <Leader>) di()<Esc>P
xnoremap <Leader>< di<><Esc>P
xnoremap <Leader>> di<><Esc>P
"autocmd BufWritePost *.py execute ':Black'
