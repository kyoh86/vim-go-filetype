if exists("b:current_syntax")
  finish
endif

syn case match

runtime! syntax/gomodver.vim

let b:current_syntax = "gosum"
