" vim: foldmethod=marker

set nocompatible

call plug#begin('~/.vim/plugged')

Plug 'ervandew/supertab'

" shows 'Nth match out of M' at every search (index of match+total # matches)
Plug 'vim-scripts/IndexedSearch'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'austintaylor/vim-commaobject'

let g:grepper = {}
let g:grepper.ag = {'grepprg': 'ag -i --vimgrep --'}
Plug 'mhinz/vim-grepper'

" vim-hardtime {{{
Plug 'takac/vim-hardtime'
let g:hardtime_default_on = 1
let g:hardtime_maxcount = 2
" }}}

" NerdTree {{{
    Plug 'scrooloose/nerdtree'
    Plug 'Xuyuanp/nerdtree-git-plugin'

    nnoremap <Bs> :<C-u>NERDTreeFind<CR>

    let NERDTreeQuitOnOpen=1
" }}}

Plug 'evidens/vim-twig'
Plug 'valloric/MatchTagAlways'

Plug 'tpope/vim-fireplace'
Plug 'vim-scripts/paredit.vim'

Plug 'posva/vim-vue'

Plug 'jiangmiao/auto-pairs'
Plug 'bling/vim-bufferline'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'ctrlpvim/ctrlp.vim'

Plug 'dyng/ctrlsf.vim'

" Syntastic {{{
Plug 'scrooloose/syntastic'
let g:syntastic_php_checkers = ['php', 'phpmd']
let g:syntastic_mod_map = {
       \ 'mode': 'passive',
       \ 'active_filetypes': ['php'] }
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
" }}}

"Plug 'joonty/vdebug'

Plug 'benmills/vimux'

Plug 'joonty/vim-phpunitqf'

" buffergator {{{
    let g:buffergator_suppress_keymaps=1
    Plug 'jeetsukumaran/vim-buffergator'
" }}}

"Plug 'vim-scripts/grep.vim'
"Plug 'shawncplus/phpcomplete.vim'

" neocomplite {{{
Plug 'Shougo/vimproc'
Plug 'Shougo/neocomplete.vim'
let g:neocomplete#enable_at_startup = 1
" }}}

Plug 'Konfekt/FastFold'

Plug 'tpope/vim-endwise'
Plug 'SirVer/ultisnips'

"Plug 'adoy/vim-php-refactoring-toolbox'
Plug 'b108/vim-php-refactoring'

Plug 'arnaud-lb/vim-php-namespace'

Plug 'danro/rename.vim'

" JSON {{{
Plug 'leshill/vim-json'
if has("autocmd")
    autocmd BufRead *.json set filetype=json
endif
" }}}

"Tagbar plugin {
    map \t :TagbarToggle<CR>
    let g:tagbar_left = 1
    let g:tagbar_compact = 1
    Plug 'majutsushi/tagbar'
" }

Plug 'vim-scripts/Git-Branch-Info'
Plug 'tpope/vim-fugitive'

Plug 'junegunn/vim-easy-align'
xmap ga <Plug>(EasyAlign)

call plug#end()

" включить загрузку плагинов по типам файлов
filetype plugin on
filetype plugin indent on
set omnifunc=syntaxcomplete#Complete
"filetype indent on " load indent file for specific file type

set noequalalways
set mouse=a
colorscheme evening
set number
set sidescroll=5
set backspace=indent,eol,start
set showmatch matchtime=3

" Search {{{
set hlsearch

set incsearch  " start search before pressed Enter
set ignorecase " ignore case when searching
set smartcase  " no ignorecase if Uppercase char present

" }}}


let mapleader = ","

" Clear a search by typing ,<space>
nnoremap <leader><space> :noh<cr>

" Tell vim to remember certain things when we exit
" '10 : marks will be remembered for up to 10 previously edited files
" "100 : will save up to 100 lines for each register
" :20 : up to 20 lines of command-line history will be remembered
" % : saves and restores the buffer list
" n... : where to save the viminfo files
set viminfo='10,\"100,:100,n~/.viminfo

let xml_tag_completion_map = ">>"

set showcmd

" Не выгружать буфер, когда переключаемся на другой
" Это позволяет редактировать несколько файлов в один и тот же момент без необходимости сохранения каждый раз
" когда переключаешься между ними
set hidden

set laststatus=2
set statusline=\ %f\ %m

" Syntastic status {{{
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
" }}}

set statusline+=%=
set statusline+=\"%F\"
set statusline+=\ →\ %{&fileencoding} "кодировка, в которой файл сохраняется на диск
set statusline+=\ %r
set statusline+=\ %#LineNrSl#\ %l\ %##\ of\ %L\ (%p%%) "номер текущей строки, общее количество строк, % от файла
set statusline+=,\ col\ %c\ (0x%04B)
set statusline+=\ %#FileTypeSl#\ %{strlen(&filetype)?&filetype:'none'}\ %##
set statusline+=%#GitBranchSl#%{fugitive#head()}%##

set wrap
set linebreak
set visualbell

" Раскладка {{{
set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0
highlight lCursor ctermfg=NONE ctermbg=Cyan

function! MyKeyMapHighlight()
    if &iminsert == 0
        hi StatusLine ctermfg=White guifg=White
    else
        hi StatusLine ctermfg=DarkGreen guifg=DarkGreen
    endif
endfunction

call MyKeyMapHighlight()

au WinEnter * :call MyKeyMapHighlight()

cmap <silent> <C-F> <C-^>
imap <silent> <C-F> <C-^>X<Esc>:call MyKeyMapHighlight()<CR>a<C-H>
nmap <silent> <C-F> a<C-^><Esc>:call MyKeyMapHighlight()<CR>
vmap <silent> <C-F> <Esc>a<C-^><Esc>:call MyKeyMapHighlight()<CR>gv
" }}}

set autoindent
set smartindent

set splitright

" < & > - äåëàåì îòñòóïû äëÿ áëîêîâ
vmap < <gv
vmap > >gv

set complete=""
set complete+=.
set complete+=k
set complete+=b
set complete+=t

set completeopt-=preview
set completeopt+=longest
"set mps-=[:]

nnoremap \w  :w<CR>

set tabstop=4 shiftwidth=4 smarttab expandtab softtabstop=4

au BufNewFile,BufRead *.map         setf map

au FileType make setlocal noexpandtab

syntax on
highlight Folded ctermbg=4 ctermfg=8 term=bold

nnoremap <silent> <F4> :CtrlPBuffer<CR>
nnoremap <F5> :bp<CR>
nnoremap <F6> :bn<CR>

nnoremap p ]p
nnoremap P ]P

set listchars=tab:▸\ ,trail:·
set list

" More useful command-line-like tab completion
set wildmenu
set wildmode=list:longest

"set relativenumber

" Disables arrow keys in normal mode to enforce use of hjkl {{{
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
" }}}

nnoremap j gj
nnoremap k gk

highlight LineNrSl ctermbg=Blue
highlight FileTypeSl ctermbg=Blue
highlight GitBranchSl ctermbg=Yellow

set encoding=utf8
set fileencoding=utf8
set tenc=utf8

set noswapfile

set fileencodings=utf8,cp1251

if has("autocmd")
    autocmd BufRead *.sql set filetype=mysql
    autocmd BufRead *.html.twig set filetype=htmljinja
endif

" CtrlP plugin
set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_map = '<c-p>'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = {
    \ 'dir': 'extra'
    \ }

"Взято из https://github.com/pepellou/vim-tricks: {{{{

"With this shortcut, you now have the choice to run the command :W (instead of normal :w), which will ask you for your sudoer password and, once entered, will scale the privileges and save the file.
command! W w !sudo tee % > /dev/null

"But in order to be more efficient, it's very important for me to save my folds whenever I leave a file and restore them when opening it. That's what I get with this:
au BufWinLeave * silent! mkview
au BufWinEnter * silent! loadview

" }}}}

function! NewJsFile()
    let fn=expand("%")
    if match(fn, "\\<models\\|views\\>/") >= 0
        if match(fn, "\\<models\\>/") >= 0
            let parentModule = 'Backbone.Model'
            let parent = 'BackboneModel'
        elseif match(fn, "\\<views\\>/") >= 0
            let parentModule = 'Backbone.View'
            let parent = 'BackboneView'
        endif
        exe "normal idefine([\"" . parentModule . "\"], function(" . parent . ") {\<Return>return " . parent . ".extend({\<Return>});\<Return>});\<Esc><<"
    endif
endfunction

au BufNewFile *.js call NewJsFile()

" Automatically create directories if they don't exist
augroup Mkdir
  autocmd!
  autocmd BufWritePre *
    \ if !isdirectory(expand("<afile>:p:h")) |
        \ call mkdir(expand("<afile>:p:h"), "p") |
    \ endif
augroup END

let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_collect_identifiers_from_tags_files = 1

" взято из http://stackoverflow.com/questions/14896327/ultisnips-and-youcompleteme {{{
" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
" }}}

let g:UltiSnipsEditSplit="vertical"

let Grep_Skip_Files='*~ tags cscope.out coverage.xml'
let Grep_Skip_Dirs='cache compressed'

nmap <silent> <Tab> :tabnext<CR>

highlight ColorColumn ctermbg=magenta

" взято из http://www.youtube.com/watch?v=aHm36-na4-4 {{{
"nnoremap ; :
"nnoremap : ;
" }}}

nnoremap ,g yiwIpublic<Space>function get<Esc>l~A()<CR>{<CR>}<ESC>Oreturn<Space>$this-><C-R>0;<ESC>
nnoremap ,s yiwIpublic<Space>function set<Esc>l~A($<C-R>0)<CR>{<CR>}<ESC>O$this-><C-R>0 = $<C-R>0;<CR>return<Space>$this;<ESC>

cabbrev newtab tabnew

nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

if has('path_extra')
    setglobal tags-=./tags tags-=./tags; tags^=./tags;
endif

set autoread
set history=10000

set display+=lastline
set scrolloff=1

" закрываем текущее окно по нажатию Ctrl-C
nnoremap <C-c> <C-w>c

set wildignore+=.git
set wildignore+=cscope.out
set wildignore+=tags
set wildignore+=*/vendor/*

nnoremap <leader>v :tabnew ~/.vimrc<CR>

nnoremap <leader>f :GrepperAg '\b<C-R>=expand("<cword>")<CR>\b'<CR>

" Search matches are always in center {{{
" from https://github.com/miripiruni/vimi/blob/master/.vimrc
    nnoremap n nzz
    nnoremap N Nzz
    nnoremap * *zz
    nnoremap # #zz
    nnoremap g* g*zz
    nnoremap g# g#zz
" }}}

autocmd! bufwritepost .vimrc source $MYVIMRC

if filereadable(expand("~/.vimrc.local"))
    source $HOME/.vimrc.local
endif

if filereadable(expand("./.vimrc"))
    source ./.vimrc
endif

iabbr -- —

cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h') . '/' : '%%'
