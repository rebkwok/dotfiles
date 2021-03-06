filetype off
" call pathogen#runtime_append_all_bundles()
" call pathogen#helptags()
" call pathogen#infect()

filetype plugin indent off
set runtimepath+=/usr/local/go/misc/vim
filetype plugin indent on

set modelines=5
set ts=4 sw=4 expandtab smartindent

au BufRead,BufNewFile Makefile*	set ts=4 sw=4 noexpandtab nosmartindent

au BufRead,BufNewFile *.coffee	set ts=4 sw=4 expandtab smartindent
au BufRead,BufNewFile *.jss     set ts=4 sw=4 expandtab smartindent
au BufRead,BufNewFile *.js      set ts=4 sw=4 noexpandtab smartindent
au BufRead,BufNewFile *.yaml,*.yml    set ts=2 sw=2 expandtab smartindent
au BufRead,BufNewFile *.prolog  set ft=prolog
au BufRead,BufNewFile Vagrantfile  set ft=ruby

au BufRead,BufNewFile *.go set nu
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)

" Use the below highlight group when displaying bad whitespace is desired.
highlight BadWhitespace ctermbg=red guibg=red
" Display tabs at the beginning of a line in Python mode as bad.
au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/
" Make trailing whitespace be flagged as bad.
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

set encoding=utf-8

let python_highlight_all=1

set background=dark
" colorscheme solarized

" Split pane navigation:
map <c-Down> <c-w>j
map <c-Up> <c-w>k
map <c-Right> <c-w>l
map <c-Left> <c-w>h

" let $PYTHONHOME='/usr/local/Cellar/python/2.7.3/'
let g:pep8_map='<leader>8'

au FileType python set omnifunc=pythoncomplete#Complete
let g:SuperTabDefaultCompletionType = "context"

syntax on                   " syntax highlighing
filetype on                 " try to detect filetypes
filetype plugin indent on   " enable loading indent file for filetype

let g:pymode_folding = 0

augroup filetypedetect
    autocmd BufNew,BufNewFile,BufRead *.txt,*.text,*.md,*.markdown :setfiletype markdown
augroup END

set synmaxcol=50000
set ruler
set number

autocmd filetype crontab setlocal nobackup nowritebackup
