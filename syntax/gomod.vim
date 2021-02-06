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

" hi versions:
"  * vX.Y.Z-pre
"  * vX.Y.Z
"  * vX.0.0-yyyyymmddhhmmss-abcdefabcdef
"  * vX.Y.Z-pre.0.yyyymmddhhmmss-abcdefabcdef
"  * vX.Y.(Z+1)-0.yyyymmddhhss-abcdefabcdef
"  see https://godoc.org/golang.org/x/tools/internal/semver for more
"  information about how semantic versions are parsed and
"  https://golang.org/cmd/go/ for how pseudo-versions and +incompatible
"  are applied.

" match vX.Y.Z and their prereleases
syn match gomodVersion "v\d\+\.\d\+\.\d\+\%(-\%([0-9A-Za-z-]\+\)\%(\.[0-9A-Za-z-]\+\)*\)\?\%(+\%([0-9A-Za-z-]\+\)\(\.[0-9A-Za-z-]\+\)*\)\?"
"                          ^--- version ---^^------------ pre-release  ---------------------^^--------------- metadata ---------------------^
"                          ^--------------------------------------- semantic version -------------------------------------------------------^

" match pseudo versions
" without a major version before the commit (e.g.  vX.0.0-yyyymmddhhmmss-abcdefabcdef)
syn match gomodVersion  "v\d\+\.0\.0-\d\{14\}-\x\+"
" when most recent version before target is a pre-release
syn match gomodVersion  "v\d\+\.\d\+\.\d\+-\%([0-9A-Za-z-]\+\)\%(\.[0-9A-Za-z-]\+\)*\%(+\%([0-9A-Za-z-]\+\)\(\.[0-9A-Za-z-]\+\)*\)\?\.0\.\d\{14}-\x\+"
"                          ^--- version ---^^--- ------ pre-release -----------------^^--------------- metadata ---------------------^
"                          ^------------------------------------- semantic version --------------------------------------------------^
" most recent version before the target is X.Y.Z
syn match gomodVersion "v\d\+\.\d\+\.\d\+\%(+\%([0-9A-Za-z-]\+\)\(\.[0-9A-Za-z-]\+\)*\)\?-0\.\d\{14}-\x\+"
"                          ^--- version ---^^--------------- metadata ---------------------^

" match incompatible vX.Y.Z and their prereleases
syn match gomodVersion "v[2-9]\{1}\d*\.\d\+\.\d\+\%(-\%([0-9A-Za-z-]\+\)\%(\.[0-9A-Za-z-]\+\)*\)\?\%(+\%([0-9A-Za-z-]\+\)\(\.[0-9A-Za-z-]\+\)*\)\?+incompatible"
"                          ^------- version -------^^------------- pre-release ---------------------^^--------------- metadata ---------------------^
"               	         ^------------------------------------------- semantic version -----------------------------------------------------------^

" match incompatible pseudo versions
" incompatible without a major version before the commit (e.g.  vX.0.0-yyyymmddhhmmss-abcdefabcdef)
syn match gomodVersion "v[2-9]\{1}\d*\.0\.0-\d\{14\}-\x\++incompatible"
" when most recent version before target is a pre-release
syn match gomodVersion "v[2-9]\{1}\d*\.\d\+\.\d\+-\%([0-9A-Za-z-]\+\)\%(\.[0-9A-Za-z-]\+\)*\%(+\%([0-9A-Za-z-]\+\)\(\.[0-9A-Za-z-]\+\)*\)\?\.0\.\d\{14}-\x\++incompatible"
"                          ^------- version -------^^---------- pre-release -----------------^^--------------- metadata ---------------------^
"                          ^---------------------------------------- semantic version ------------------------------------------------------^
" most recent version before the target is X.Y.Z
syn match gomodVersion "v[2-9]\{1}\d*\.\d\+\.\d\+\%(+\%([0-9A-Za-z-]\+\)\%(\.[0-9A-Za-z-]\+\)*\)\?-0\.\d\{14}-\x\++incompatible"
"                          ^------- version -------^^---------------- metadata ---------------------^
hi def link gomodVersion Identifier

let b:current_syntax = "gomod"

" vim: sw=2 ts=2 et colorcolumn=17,40
