let s:cpo_save = &cpo
set cpo&vim

autocmd BufRead,BufNewFile *.go     setfiletype go
autocmd BufRead,BufNewFile *.gohtml setfiletype gohtmltmpl
autocmd BufRead,BufNewFile *.gotxt  setfiletype gotexttmpl

if !exists('g:go_mod_filetype')
    let g:go_mod_filetype = 'auto'
endif

if g:go_mod_filetype ==# 'always'
    autocmd BufRead,BufNewFile go.sum setfiletype gosum
    autocmd BufRead,BufNewFile go.mod setfiletype gomod
elseif g:go_mod_filetype ==# 'auto'
    call go#filetype#define_gomod_filetypes()
endif

let &cpo = s:cpo_save
unlet s:cpo_save
