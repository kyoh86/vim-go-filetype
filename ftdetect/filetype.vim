let s:cpo_save = &cpo
set cpo&vim

autocmd BufRead,BufNewFile *.go     setfiletype go
autocmd BufRead,BufNewFile *.gohtml setfiletype gohtmltmpl
autocmd BufRead,BufNewFile *.gotxt  setfiletype gotexttmpl
autocmd BufRead,BufNewFile go.sum   setfiletype gosum

autocmd! BufRead,BufNewFile *.mod,*.MOD
autocmd BufRead,BufNewFile go.mod call s:gomod()

function! s:gomod()
  for l:i in range(1, line('$'))
    let l:l = getline(l:i)
    if l:l ==# '' || l:l[:1] ==# '//'
      continue
    endif

    if l:l =~# '^module .\+'
      setfiletype gomod
    endif

    break
  endfor
endfunction

let &cpo = s:cpo_save
unlet s:cpo_save
