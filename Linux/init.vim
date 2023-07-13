" Detect the type of file that is edited
filetype on

" Print the line number in front of each line
set number
" Show the line number in another font or color
highlight LineNr ctermbg=DarkGray ctermfg=Black cterm=italic

" Use the appropriate number of spaces to insert a Tab
set expandtab
" Number of spaces that a Tab or BS counts
set softtabstop=4
" Smart autoindentation when starting a new line
set smartindent
" Number of spaces to use for each step of (auto)indent
set shiftwidth=4

" Lines longer than the width of the window will wrap and displaying continues on the next line
set nowrap

" Influences the working of BS, Del, CTRL-W and CTRL-U in Insert mode
set backspace=indent,eol,start
" indent: Allow backspacing over autoindent
" eol: Allow backspacing over line breaks
" start: Allow backspacing over the start of insert; CTRL-W and CTRL-U stop once at the start of insert

" Directory for the swap file
set directory=/tmp
" Directory for the backup file
set backupdir=/tmp

" Specifies for wich events the bell will not be run
set belloff=all
