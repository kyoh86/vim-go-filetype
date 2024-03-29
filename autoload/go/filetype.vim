function go#filetype#define_gomod_filetypes()
    autocmd! BufRead,BufNewFile *.sum
    autocmd BufRead,BufNewFile go.sum   call s:gosum()
    autocmd! BufRead,BufNewFile *.mod
    autocmd BufRead,BufNewFile go.mod   call s:gomod()

    function! s:gosum()
        for l:i in range(1, min([line('$'), 10]))
            let l:l = getline(l:i)
            if l:l ==# '' || l:l =~# '^[^ ]\+ v\d[^ ]\+ h1:[^ ]\+=$'
                continue
            else
                return
            endif
        endfor
        setfiletype gosum
    endfunction

    function! s:gomod()
        for l:i in range(1, min([line('$'), 100]))
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
endfunction
