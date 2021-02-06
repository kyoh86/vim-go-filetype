if exists("b:current_syntax")
  finish
endif

syn sync minlines=500
syn case match

syn keyword     goPackage              package
hi def link     goPackage              Statement


" Keywords within functions
syn keyword     goStatement            defer go goto return break continue fallthrough
syn keyword     goConditional          if else switch select
syn keyword     goLabel                case default
syn keyword     goRepeat               for range

hi def link     goStatement            Statement
hi def link     goConditional          Conditional
hi def link     goLabel                Label
hi def link     goRepeat               Repeat

" Predefined types
syn keyword     goType                 chan map bool string error
syn keyword     goSignedInts           int int8 int16 int32 int64 rune
syn keyword     goUnsignedInts         byte uint uint8 uint16 uint32 uint64 uintptr
syn keyword     goFloats               float32 float64
syn keyword     goComplexes            complex64 complex128

hi def link     goType                 Type
hi def link     goSignedInts           Type
hi def link     goUnsignedInts         Type
hi def link     goFloats               Type
hi def link     goComplexes            Type

" Predefined functions and values
syn keyword     goBuiltins             append cap close complex copy delete imag len
syn keyword     goBuiltins             make new panic print println real recover
syn keyword     goBoolean              true false
syn keyword     goIdentifiers          nil iota

hi def link     goBuiltins             Identifier
hi def link     goBoolean              Boolean
hi def link     goIdentifiers          goBoolean

" Comments; their contents
syn keyword     goTodo                 contained TODO FIXME XXX BUG NOTE
syn cluster     goCommentGroup         contains=goTodo
syn region      goComment              start="//" end="$" contains=@goCommentGroup,@Spell
syn region      goComment              start="/\*" end="\*/" contains=@goCommentGroup,@Spell

hi def link     goComment              Comment
hi def link     goTodo                 Todo

" Go escapes
syn match       goEscapeOctal          display contained "\\[0-7]\{3}"
syn match       goEscapeC              display contained +\\[abfnrtv\\'"]+
syn match       goEscapeX              display contained "\\x\x\{2}"
syn match       goEscapeU              display contained "\\u\x\{4}"
syn match       goEscapeBigU           display contained "\\U\x\{8}"
syn match       goEscapeError          display contained +\\[^0-7xuUabfnrtv\\'"]+

hi def link     goEscapeOctal          goSpecialString
hi def link     goEscapeC              goSpecialString
hi def link     goEscapeX              goSpecialString
hi def link     goEscapeU              goSpecialString
hi def link     goEscapeBigU           goSpecialString
hi def link     goSpecialString        Special
hi def link     goEscapeError          Error

" Strings and their contents
syn cluster     goStringGroup          contains=goEscapeOctal,goEscapeC,goEscapeX,goEscapeU,goEscapeBigU,goEscapeError
syn region      goString               start=+"+ skip=+\\\\\|\\"+ end=+"+ contains=@goStringGroup
syn region      goRawString            start=+`+ end=+`+

hi def link     goString               String
hi def link     goRawString            String

" Characters; their contents
syn cluster     goCharacterGroup       contains=goEscapeOctal,goEscapeC,goEscapeX,goEscapeU,goEscapeBigU
syn region      goCharacter            start=+'+ skip=+\\\\\|\\'+ end=+'+ contains=@goCharacterGroup

hi def link     goCharacter            Character

" Regions
syn region      goParen                start='(' end=')' transparent
syn region      goBlock                start="{" end="}" transparent

" import
syn region      goImport               start='import (' end=')' transparent contains=goImport,goString,goComment
syn keyword     goImport               import    contained
hi def link     goImport               Statement

" var
syn keyword     goVar                  var       contained
syn region      goVar                  start='var ('   end='^\s*)$' transparent contains=ALLBUT,goParen,goBlock
hi def link     goVar                  Keyword

" const
syn keyword     goConst                const     contained
syn region      goConst                start='const (' end='^\s*)$' transparent contains=ALLBUT,goParen,goBlock
hi def link     goConst                Keyword

" Single-line var, const, and import.
syn match       goSingleDecl           /\%(import\|var\|const\) [^(]\@=/ contains=goImport,goVar,goConst

" Integers
syn match       goDecimalInt           "\<-\=\(0\|[1-9]_\?\(\d\|\d\+_\?\d\+\)*\)\%([Ee][-+]\=\d\+\)\=\>"
syn match       goDecimalError         "\<-\=\(_\(\d\+_*\)\+\|\([1-9]\d*_*\)\+__\(\d\+_*\)\+\|\([1-9]\d*_*\)\+_\+\)\%([Ee][-+]\=\d\+\)\=\>"
syn match       goHexadecimalInt       "\<-\=0[xX]_\?\(\x\+_\?\)\+\>"
syn match       goHexadecimalError     "\<-\=0[xX]_\?\(\x\+_\?\)*\(\([^ \t0-9A-Fa-f_]\|__\)\S*\|_\)\>"
syn match       goOctalInt             "\<-\=0[oO]\?_\?\(\o\+_\?\)\+\>"
syn match       goOctalError           "\<-\=0[0-7oO_]*\(\([^ \t0-7oOxX_/)\]\}\:]\|[oO]\{2,\}\|__\)\S*\|_\|[oOxX]\)\>"
syn match       goBinaryInt            "\<-\=0[bB]_\?\([01]\+_\?\)\+\>"
syn match       goBinaryError          "\<-\=0[bB]_\?[01_]*\([^ \t01_]\S*\|__\S*\|_\)\>"

hi def link     goDecimalInt           Integer
hi def link     goDecimalError         Error
hi def link     goHexadecimalInt       Integer
hi def link     goHexadecimalError     Error
hi def link     goOctalInt             Integer
hi def link     goOctalError           Error
hi def link     goBinaryInt            Integer
hi def link     goBinaryError          Error
hi def link     Integer                Number

" Floating point
syn match       goFloat                "\<-\=\d\+\.\d*\%([Ee][-+]\=\d\+\)\=\>"
syn match       goFloat                "\<-\=\.\d\+\%([Ee][-+]\=\d\+\)\=\>"

hi def link     goFloat                Float

" Imaginary literals
syn match       goImaginary            "\<-\=\d\+i\>"
syn match       goImaginary            "\<-\=\d\+[Ee][-+]\=\d\+i\>"
syn match       goImaginaryFloat       "\<-\=\d\+\.\d*\%([Ee][-+]\=\d\+\)\=i\>"
syn match       goImaginaryFloat       "\<-\=\.\d\+\%([Ee][-+]\=\d\+\)\=i\>"

hi def link     goImaginary            Number
hi def link     goImaginaryFloat       Float

syn match       goVarArgs              /\.\.\./

syn keyword     goDeclaration          func type
hi def link     goDeclaration          Keyword

syn keyword     goDeclType             struct interface
hi def link     goDeclType             Keyword

let b:current_syntax = "go"

" vim: sw=2 ts=2 et colorcolumn=17,40
