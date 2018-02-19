" Vim syntax file
" Language:         maaps
" Maintainer:       Klaus Wagner <nenioscio@gmail.com>
" Latest Revision:  2015-04-17

if exists("b:current_syntax")
  finish
endif

unlet! b:current_syntax
syn include @Python syntax/python.vim

let s:cpo_save = &cpo
set cpo&vim

syn keyword maapsTodo         contained TODO FIXME XXX NOTE

syn region  maapsComment      display oneline start='#' end='$'
                                \ contains=maapsTodo,@Spell

" Blocks
syn region  maapsChainBlock   start=+{+ skip=+{}\|\${.*}+ end=+}+ fold transparent skipwhite
                                \ contained contains=maapsStart,maapsEntryBlock,maapsComment
syn region  maapsEntryBlock   matchgroup=Snip start=+{+ skip=+{}\|\${.*}+ end=+}+ fold transparent skipwhite
                                \ contained contains=maapsStart,maapsCodeBlock,maapsComment
syn region  maapsCodeBlock    matchgroup=Snip start=+{+ skip=+{}\|\${.*}+ end=+}+ fold transparent skipwhite
                                \ contained contains=@Python,maapsCodeBlock,maapsValue


" Anchoring
syn match   maapsStart        "^" nextgroup=maapsKeyword,maapsCodeKeyword,maapsChainKeyword,maapsGenKeyword,maapsEntryKeyword skipwhite contained


" Blocks
syn keyword maapsCodeKeyword  code context nextgroup=maapsCodeOperator skipwhite contained
syn match   maapsCodeOperator "=" nextgroup=maapsCodeBlock skipwhite contained

syn keyword maapsGenKeyword   nextgroup=maapsGenOperator skipwhite contained delay
syn match   maapsGenOperator  "=" nextgroup=maapsValue skipwhite contained
syn match   maapsValue        "${.*}\|\"\${.*}\"\|'\${.*}\'" contained

syn keyword maapsKeyword      contained nextgroup=maapsName1 skipwhite entrypoint call module onexception onException
syn match   maapsName1        "[A-Za-z\._ \"]\+" nextgroup=maapsName2,maapsEntryBlock contained skipwhite
syn match   maapsName2        "[A-Za-z\._ \"]\+" nextgroup=maapsEntryBlock contained skipwhite

syn keyword maapsChainKeyword chain nextgroup=maapsChainname skipwhite
syn match   maapsChainName    "[A-Za-z\.]\+" nextgroup=maapsChainBlock contained skipwhite

syn keyword maapsImportKeyword import nextgroup=maapsImportName
syn match   maapsImportName    "[A-Za-z\._]\+" contained skipwhite


" linking

hi def link maapsTodo         Todo
hi def link maapsComment      Comment

hi def link maapsChainKeyword Keyword
hi def link maapsCodeKeyword  Keyword
hi def link maapsGenKeyword   Keyword
hi def link maapsEntryKeyword Keyword
hi def link maapsLoopKeyword  Keyword
hi def link maapsImportKeyword Keyword
hi def link maapsKeyword      Keyword
hi def link maapsName1        Identifier
hi def link maapsName2        Identifier


hi def link maapsCodeOperator Special
hi def link maapsChainName    Identifier
hi def link maapsImportName   Identifier
hi def link maapsValue        PreProc
hi def link maapsGenOperator  Special

hi link Snip Keyword

let b:current_syntax = "maaps"

let &cpo = s:cpo_save
unlet s:cpo_save
