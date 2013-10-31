filetype off
" call pathogen#runtime_append_all_bundles()
" call pathogen#helptags()
call pathogen#infect()

set modelines=5
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

set background=dark
colorscheme solarized

" Split pane navigation:
map <c-Down> <c-w>j
map <c-Up> <c-w>k
map <c-Right> <c-w>l
map <c-Left> <c-w>h

" let $PYTHONHOME='/usr/local/Cellar/python/2.7.3/'
let g:pep8_map='<leader>8'

au FileType python set omnifunc=pythoncomplete#Complete
let g:SuperTabDefaultCompletionType = "context"

" Add the virtualenv's site-packages to vim path
py << EOF
import os.path
import sys
import vim
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    sys.path.insert(0, project_base_dir)
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF

syntax on                   " syntax highlighing
filetype on                 " try to detect filetypes
filetype plugin indent on   " enable loading indent file for filetype

let g:pymode_folding = 0
