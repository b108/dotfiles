"Vundle require
set nocompatible
filetype off
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

Plugin 'sjl/badwolf'
Plugin 'vim-scripts/IndexedSearch.git'

Plugin 'austintaylor/vim-commaobject'

" Nerd tree {
    Plugin 'scrooloose/nerdtree'
    Plugin 'Xuyuanp/nerdtree-git-plugin'
" }

" Plugin 'kristijanhusak/vim-multiple-cursors'

Plugin 'evidens/vim-twig'
Plugin 'valloric/MatchTagAlways'

Plugin 'jiangmiao/auto-pairs'
Plugin 'bling/vim-bufferline'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'jeetsukumaran/vim-buffergator'
"Plugin 'vim-scripts/grep.vim'
Plugin 'adoy/vim-php-refactoring-toolbox'
Plugin 'shawncplus/phpcomplete.vim'
Plugin 'Shougo/neocomplete.vim'
Plugin 'tpope/vim-endwise'
Plugin 'SirVer/ultisnips'

" Emmet plugin {
    let g:user_emmet_leader_key='<C-M>'
    let g:user_emmet_mode='a'    "enable all function in all mode.
    Plugin 'mattn/emmet-vim'
" }

Plugin 'StanAngeloff/php.vim', { 'for': 'php' }

"Tagbar plugin {
    map \t :TagbarToggle<CR>
    let g:tagbar_left = 1
    let g:tagbar_compact = 1
    Plugin 'majutsushi/tagbar'
" }



" Быстрый поиск по файлам {
    let g:ack_default_options = " -s -H --nocolor --nogroup --column --ignore-dir=tests/vendor --ignore-dir=extra/vendor --ignore-dir=cache --php"
    Plugin 'mileszs/ack.vim'
" }

Plugin 'vim-scripts/Git-Branch-Info'
Plugin 'tpope/vim-fugitive'

call vundle#end()

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
set bs=2
set showmatch matchtime=3
set hlsearch

" Clear a search by typing ,<space>
nnoremap <leader><space> :noh<cr>

" Tell vim to remember certain things when we exit
" '10 : marks will be remembered for up to 10 previously edited files
" "100 : will save up to 100 lines for each register
" :20 : up to 20 lines of command-line history will be remembered
" % : saves and restores the buffer list
" n... : where to save the viminfo files
set viminfo='10,\"100,:100,n~/.viminfo

set ignorecase " ignore case when searching
set smartcase " no ignorecase if Uppercase char present

let xml_tag_completion_map = ">>"

set showcmd

" Не выгружать буфер, когда переключаемся на другой
" Это позволяет редактировать несколько файлов в один и тот же момент без необходимости сохранения каждый раз
" когда переключаешься между ними
set hidden

"Используется плагин https://github.com/vim-scripts/Git-Branch-Info
function MyGitBranchInfo()
    let l:branch=GitBranchInfoTokens()[0]
    if l:branch == ""
        return ""
    else
        return " " . l:branch . " "
endfunction

set laststatus=2
set statusline=\ %f\ %m
set statusline+=%=
set statusline+=\"%F\"
set statusline+=\ →\ %{&fileencoding} "кодировка, в которой файл сохраняется на диск
set statusline+=\ %r
set statusline+=\ %#LineNrSl#\ %l\ %##\ of\ %L\ (%p%%) "номер текущей строки, общее количество строк, % от файла
set statusline+=,\ col\ %c\ (0x%04B)
set statusline+=\ %#FileTypeSl#\ %{strlen(&filetype)?&filetype:'none'}\ %##
set statusline+=%#GitBranchSl#%{MyGitBranchInfo()}%##

set wrap
set linebreak

" <!-- Раскладка
set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0
highlight lCursor ctermfg=NONE ctermbg=Cyan

set visualbell

function MyKeyMapHighlight()
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

" -->

set autoindent
set smartindent

set splitright

"imap {<CR> {<CR>}<Esc>O

imap <F2> <Esc>:w<CR>a
nnoremap <F2> :w<CR>

imap <F1> <Esc>:set<Space>nu!<CR>a
nmap <F1> :set<Space>nu!<CR>

imap <F5> <C-^>

fun! <SID>WindowWidth()
    if winwidth(0) > 90
        setlocal foldcolumn=1
        setlocal number
    else
        setlocal nonumber
        setlocal foldcolumn=0
    endif
endfun

" Ïðîáåë â íîðìàëüíîì ðåæèìå ïåðåëèñòûâàåò ñòðàíèöû
nmap <Space> <PageDown>

" < & > - äåëàåì îòñòóïû äëÿ áëîêîâ
vmap < <gv
vmap > >gv

" Àâòîçàâåðøåíèå ñëîâ ïî tab =)
function InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction

"imap <tab> <c-r>=InsertTabWrapper()<cr>

set complete=""
set complete+=.
set complete+=k
set complete+=b
set complete+=t

set completeopt-=preview
set completeopt+=longest
"set mps-=[:]

nnoremap \w  :w<CR>

function QuickMake()
    map <C-C> :make<CR><CR><CR>:cw<CR>
endfun

function Perlfile()
    set foldmethod=expr
    set foldexpr=getline(v:lnum-1)=~'^\\s*sub\\s\\+\\w\\+\\s*{\\s*$'?'>1':getline(v:lnum+1)=~'^}$'?'s1':'-1'
endfun

set tabstop=4 shiftwidth=4 smarttab expandtab softtabstop=4

function PythonFile()
    set autoindent
endfun

function AdaFile()
    setlocal autoindent
    map \tio ggOwith Ada.Text_IO; use Ada.Text_IO;<CR><ESC>
    exe QuickMake()
endfun

function CFile()
    exe QuickMake()
endfun

function Makefile()
    setlocal noexpandtab
endfun

au Filetype perl exe Perlfile()
au Filetype python exe PythonFile()
au Filetype ada exe AdaFile()
au Filetype c exe CFile()
au BufNewFile,BufRead *.map         setf map

au FileType make exe Makefile()

syntax on
highlight Folded ctermbg=4 ctermfg=8 term=bold

nnoremap <F4> :buffers<CR>:buffer<SPACE>
nnoremap <F5> :bp<CR>
nnoremap <F6> :bn<CR>

"MRU plugin
nnoremap \\ :MRU<CR>

let g:CodeCompl_Hotkey = '<C-z>'

nnoremap p ]p
nnoremap P ]P

set listchars=tab:▸\ ,eol:¬

" More useful command-line-like tab completion
set wildmenu
set wildmode=list:longest

"set relativenumber

" Disables arrow keys in normal mode to enforce use of hjkl
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
nnoremap j gj
nnoremap k gk

highlight LineNrSl ctermbg=Blue
highlight FileTypeSl ctermbg=Blue
highlight GitBranchSl ctermbg=Yellow

set encoding=utf8
set fileencoding=cp1251
set tenc=utf8

set noswapfile

nmap <silent> <F8> :call AutoCloseToggle()<CR>

set fileencodings=utf8,cp1251

"vmap ,t cctnwp<Tab>translate<Tab>word<Esc>f";a'<C-R>"'<ESC>

au! BufWriteCmd  *.php call PHPsynCHK()

if !exists('*PHPsynCHK')
  function! PHPsynCHK()
    "exe SyntasticCheck()
    ccl
    let winnum = winnr() " get current window number
    let linenum = line('.')
    let colnum = col('.')
    "silent execute "%!php -l -f /dev/stdin | sed 's@\\/dev\\/stdin@".bufname("%")."@g' >/tmp/vimerr; cat"
    let tmp_file = '/tmp/vim_tmp.php'
    silent execute "w! " . tmp_file
    silent execute "!php -l -f '" . tmp_file . "' 2>&1 | sed 's\\#" . tmp_file . "\\#".bufname("%")."\\#g' >/tmp/vimerr"
    set errorformat=%m\ in\ %f\ on\ line\ %l
    silent cf /tmp/vimerr
    cw " open the error window if it contains error
    " return to the window with cursor set on the line of the first error (if any)
    execute winnum . "wincmd w"
    "silent undo
    silent cf
    if 1 == len(getqflist())
      call s:Mkdir()
      w
      call cursor(linenum, colnum)
    endif
  endfunction
endif

set errorformat=%m\ in\ %f\ on\ line\ %l

"inoremap jj <Esc>

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


iabbr functoin function

"autocmd InsertEnter *.php set foldmethod=syntax
"autocmd InsertLeave *.php set foldmethod=syntax

"Взято из https://github.com/pepellou/vim-tricks: {{{{

"With this shortcut, you now have the choice to run the command :W (instead of normal :w), which will ask you for your sudoer password and, once entered, will scale the privileges and save the file.
command W w !sudo tee % > /dev/null

"But in order to be more efficient, it's very important for me to save my folds whenever I leave a file and restore them when opening it. That's what I get with this:
au BufWinLeave * silent! mkview
au BufWinEnter * silent! loadview

" }}}}

nnoremap ,m :MarksBrowser<CR>

function NewJsFile()
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
au BufNewFile * set fileencoding=utf-8

function s:Mkdir()
  let dir = expand('%:p:h')

  if !isdirectory(dir)
    call mkdir(dir, 'p')
    echo 'Created non-existing directory: '.dir
  endif
endfunction

function GoPhpUnitError()
    let makeprg=&makeprg
    let errorformat=&errorformat

    set makeprg=cat
    set errorformat=%E%n)\ %.%#,%Z%f:%l,%C%m,%-G%.%#

    make /tmp/phpunit.output

    let &makeprg=makeprg
    let &errorformat=errorformat
endfunction

nnoremap <F3> :call GoPhpUnitError()<CR><CR>

nnoremap <leader>a :NERDTreeToggle<CR>

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

nnoremap ,t :sp tests/php-unit/<C-R>=expand("%:r")<CR>Test.php<CR>

" удаляем двоеточие «:» из списка, иначе в php не ищутся
" вхождения констант вида self::CONSTANT_NAME
" setlocal iskeyword-=58
autocmd BufEnter *.php setlocal iskeyword-=58

autocmd BufNewFile,BufRead *.yml setlocal iskeyword+=.
autocmd BufNewFile,BufRead *.php call matchadd('ColorColumn', '\%81v', 100)

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

nnoremap <silent> ,a :NERDTreeToggle<CR>

"start search before pressed Enter
set incsearch

if has('path_extra')
    setglobal tags-=./tags tags-=./tags; tags^=./tags;
endif

set autoread
set history=1000

set display+=lastline
set scrolloff=1

" закрываем текущее окно по нажатию Ctrl-C
nnoremap <C-c> <C-w>c

set wildignore+=.git

nnoremap ,v :tabnew ~/.vimrc<CR>

autocmd BufNewFile,BufRead *.php setlocal foldmethod=expr foldexpr=PHPFold(v:lnum)

function! PHPFold(lnum)
  let current = getline(a:lnum)

  if current =~# '\s*}$'
    let level = indent(a:lnum) / &l:shiftwidth
    return level > 2 ? '=' : '<' . (level + 1)
  elseif current =~# '^\s*\('
                 \ . '\(\(final\|private\|protected\|public\|static\)\s\)*function'
                 \ . '\|\(abstract\s\)\?class'
                 \ . '\|interface'
                 \ . '\|namespace'
                 \ . '\|trait'
                 \ . '\)[^;]*$'
    let level = indent(a:lnum) / &l:shiftwidth
    return level > 2 ? '=' : '>' . (level + 1)
  else
    return '='
  endif
endfunction

" Сокращения внутри phpunit-файлов {
autocmd BufNewFile,BufRead *Test.php abbreviate <buffer> atrue $this->assertTrue(
autocmd BufNewFile,BufRead *Test.php abbreviate <buffer> aeq $this->assertEquals(
" }

source ~/.vimrc.local