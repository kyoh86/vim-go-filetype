if exists("b:current_syntax")
  finish
endif

syn case match

" match keywords
syn keyword     gomodModule            module
syn keyword     gomodGo                go contained
syn keyword     gomodRequire           require
syn keyword     gomodExclude           exclude
syn keyword     gomodReplace           replace

" require, exclude, replace, and go can be also grouped into block
syn region      gomodRequire           start='require (' end=')' transparent contains=gomodRequire,gomodVersion
syn region      gomodExclude           start='exclude (' end=')' transparent contains=gomodExclude,gomodVersion
syn region      gomodReplace           start='replace (' end=')' transparent contains=gomodReplace,gomodVersion
syn match       gomodGo                '^go .*$' transparent contains=gomodGo,gomodGoVersion

" set highlights
hi def link     gomodModule            Keyword
hi def link     gomodGo                Keyword
hi def link     gomodRequire           Keyword
hi def link     gomodExclude           Keyword
hi def link     gomodReplace           Keyword

" comments are always in form of // ...
syn region      gomodComment           start="//" end="$" contains=@Spell
hi def link     gomodComment           Comment

" make sure quoted import paths are higlighted
syn region      gomodString            start=+"+ skip=+\\\\\|\\"+ end=+"+ 
hi def link     gomodString            String 

" replace operator is in the form of '=>'
syn match       gomodReplaceOperator   "\v\=\>"
hi def link     gomodReplaceOperator   Operator

" match go versions
syn match       gomodGoVersion         "1\.\d\+" contained
hi def link     gomodGoVersion         Identifier

runtime! syntax/gomodver.vim

let b:current_syntax = "gomod"

" vim: shiftwidth=2 tabstop=2 expandtab colorcolumn=17,40
