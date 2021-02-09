if exists("g:current_compiler")
  finish
endif
let g:current_compiler = "go"

let s:cpo_save = &cpo
set cpo&vim

if exists(":CompilerSet") != 2
  command -nargs=* CompilerSet setlocal <args>
endif

set cpo-=C

if filereadable("makefile") || filereadable("Makefile")
  CompilerSet makeprg=make
else
  CompilerSet makeprg=go\ build
endif

" Define the patterns that will be recognized by QuickFix when parsing the
" output of Go command that use this errorforamt (when called make, cexpr or
" lmake, lexpr).
CompilerSet errorformat =%-G#\ %.%#                                 " Ignore lines beginning with '#' ('# command-line-arguments' line sometimes appears?)
CompilerSet errorformat+=%-G%.%#panic:\ %m                          " Ignore lines containing 'panic: message'
CompilerSet errorformat+=%Ecan\'t\ load\ package:\ %m               " Start of multiline error string is 'can\'t load package'
CompilerSet errorformat+=%A%\\%%(%[%^:]%\\+:\ %\\)%\\?%f:%l:%c:\ %m " Start of multiline unspecified string is 'filename:linenumber:columnnumber:'
CompilerSet errorformat+=%A%\\%%(%[%^:]%\\+:\ %\\)%\\?%f:%l:\ %m    " Start of multiline unspecified string is 'filename:linenumber:'
CompilerSet errorformat+=%C%*\\s%m                                  " Continuation of multiline error message is indented
CompilerSet errorformat+=%-G%.%#                                    " All lines not matching any of the above patterns are ignored

let &cpo = s:cpo_save
unlet s:cpo_save
