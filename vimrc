call pathogen#infect()

set ts=4 sw=4 expandtab smartindent

au BufRead,BufNewFile Makefile*	set ts=4 sw=4 noexpandtab nosmartindent

au BufRead,BufNewFile *.coffee	set ts=4 sw=4 expandtab smartindent
au BufRead,BufNewFile *.jss     set ts=4 sw=4 expandtab smartindent

" Use the below highlight group when displaying bad whitespace is desired.
highlight BadWhitespace ctermbg=red guibg=red
" Display tabs at the beginning of a line in Python mode as bad.
au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/
" Make trailing whitespace be flagged as bad.
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

set encoding=utf-8

let python_highlight_all=1
syntax on

filetype indent on

set background=dark
colorscheme solarized
