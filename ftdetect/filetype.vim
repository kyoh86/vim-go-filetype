let s:cpo_save = &cpo
set cpo&vim

autocmd BufRead,BufNewFile *.go     setfiletype go
autocmd BufRead,BufNewFile *.gohtml setfiletype gohtmltmpl
autocmd BufRead,BufNewFile *.gotxt  setfiletype gotexttmpl
autocmd BufRead,BufNewFile go.sum   call s:gosum()
autocmd BufRead,BufNewFile go.mod   call s:gomod()

function! s:gomod()
  for l:i in range(1, min([line('$'), 100]))
    let l:l = getline(l:i)
    if l:l ==# '' || l:l[:1] ==# '//'
      continue
    endif
    if l:l =~# '^module .\+'
      setlocal filetype=gomod
    endif
    break
  endfor
endfunction

function! s:gosum()
  for l:i in range(1, min([line('$'), 10]))
    let l:l = getline(l:i)
    if l:l ==# '' || l:l =~# '^[^ ]\+ v\d[^ ]\+ h1:[^ ]\+=$'
      continue
    else
      return
    endif
  endfor
  setlocal filetype=gosum
endfunction

let &cpo = s:cpo_save
unlet s:cpo_save
