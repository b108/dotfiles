" Go to file of PHP class under cursor {{{
function! PHPGoFile()
    let old_iskeyword_option = &iskeyword
    set iskeyword+=\
    let className = expand("<cword>")
    let fileOfClass = substitute(substitute(className, "\\", "/", "g"), "^/", "", "") . '.php'
    execute "set iskeyword=" . old_iskeyword_option

    let existsBufferNumberOfFile = bufnr(fileOfClass)

    if existsBufferNumberOfFile > 0
        exe existsBufferNumberOfFile . "buffer"
    elseif filereadable(fileOfClass)
        exe "e " . fnameescape(fileOfClass)
    else
        exe "normal! gf"
    endif
endfunction

nnoremap <buffer> gf :call<Space>PHPGoFile()<CR>
" }}}

" Сокращения внутри phpunit-файлов и файлов интерфейсов {{{
autocmd BufNewFile,BufReadPre *Test.php set ft=php.phpunit
autocmd BufNewFile,BufReadPre *Interface.php set ft=php.php_interface
" }}}

" Folding {{{
setlocal foldmethod=expr foldexpr=PHPFold(v:lnum)

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
" }}}

" удаляем двоеточие «:» из списка, иначе в php не ищутся
" вхождения констант вида self::CONSTANT_NAME
setlocal iskeyword-=58,$

call matchadd('ColorColumn', '\%81v', 100)
