autocmd!

set background=dark         " Assume a dark background
filetype plugin indent on   " Automatically detect file types.
syntax on                   " Syntax highlighting
set mouse=a                 " Automatically enable mouse usage
set mousehide               " Hide the mouse cursor while typing
scriptencoding utf-8
set history=1000
set spell
set hidden                  " Allow buffer switching without saving

set iskeyword-=.                    " '.' is an end of word designato
set iskeyword-=#                    " '#' is an end of word designator
set iskeyword-=-                    " '-' is an end of word designator
set backup
set undofile
set undolevels=1000
set undoreload=10000

set tabpagemax=15
set showmode


set ruler                   " Show the ruler
set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%)
set showcmd                 " Show partial commands in status line and


if has('clipboard')
    if has('unnamedplus')  " When possible use + register for copy-paste
        set clipboard=unnamed,unnamedplus
    else         " On mac and Windows, use * register for copy-paste
        set clipboard=unnamed
    endif
endif

"if has('statusline')
"    set laststatus=2
"
"    set statusline=%<%f\                     " Filename
"    set statusline+=%w%h%m%r                 " Options
"    set statusline+=\ [%{&ff}/%Y]            " Filetype
"    set statusline+=\ [%{getcwd()}]          " Current dir
"    set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
"endif

set backspace=indent,eol,start  " Backspace for dummies
set linespace=0                 " No extra spaces between rows
set number                      " Line numbers on
set showmatch                   " Show matching brackets/parenthesis
set incsearch                   " Find as you type search
set hlsearch                    " Highlight search terms
set winminheight=0              " Windows can be 0 line high
set ignorecase                  " Case insensitive search
set smartcase                   " Case sensitive when uc present
set wildmenu                    " Show list instead of just completing
set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
set scrolljump=5                " Lines to scroll when cursor leaves screen
set scrolloff=3                 " Minimum lines to keep above and below cursor
set foldenable                  " Auto fold code
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace
set smarttab

set nowrap                      " Do not wrap long lines
set autoindent                  " Indent at the same level of the previous line
set smartindent
set shiftwidth=4                " Use indents of 4 spaces
set expandtab                   " Tabs are spaces, not tabs
set tabstop=4                   " An indentation every four columns
set softtabstop=4               " Let backspace delete indent
set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
set splitright                  " Puts new vsplit windows to the right of the current
set splitbelow                  " Puts new split windows to the bottom of the current
set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)

set path+=**
set wildignore+=*/node_modules/*

set formatoptions+=r
set lazyredraw



autocmd BufNewFile,BufRead *.md set filetype=markdown
autocmd FileType c,cpp,java,go,php,javascript,puppet,python,rust,twig,xml,yml,perl,sql autocmd BufWritePre <buffer> if !exists('g:ww_keep_trailing_whitespace') | call StripTrailingWhitespace() | endif
autocmd BufNewFile,BufRead *.html.twig set filetype=html.twig
autocmd FileType haskell,puppet,ruby,yml setlocal expandtab shiftwidth=2 softtabstop=2
autocmd FileType javascript setlocal expandtab shiftwidth=2 softtabstop=2

autocmd BufNewFile,BufRead *.coffee set filetype=coffee
autocmd FileType haskell setlocal commentstring=--\ %s
autocmd FileType haskell,rust setlocal nospell

set suffixesadd=.js,.es,.jsx,.json,.css,.less,.sass,.styl,.php,.py,.md

nnoremap Y y$

" Strip whitespace {
function! StripTrailingWhitespace()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " do the business:
    %s/\s\+$//e
    " clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction
" }

syntax enable
set background=dark
set termguicolors
runtime .colors/solarized.vim
colorscheme solarized

set cursorline
highlight CursorLine guibg=Grey30
highlight clear SignColumn
highlight clear LineNr
highlight Pmenu guibg=Black40
highlight PmenuSel guibg=Grey20




" Change working directory to that of current file
set autochdir

" sudo write
cmap w!! w !sudo tee %>/dev/null


function! InitializeDirectories()
    let parent = $HOME
    let prefix = 'nvim'
    let dir_list = {
                \ 'backup': 'backupdir',
                \ 'views': 'viewdir',
                \ 'swap': 'directory' }

    if has('persistent_undo')
        let dir_list['undo'] = 'undodir'
    endif

   let common_dir = parent . '/.' . prefix

    for [dirname, settingname] in items(dir_list)
        let directory = common_dir . '/' . dirname . '/'
        if !isdirectory(directory)
            call mkdir(directory, "p")
        endif
        if !isdirectory(directory)
            echo "Warning: Unable to create backup directory: " . directory
            echo "Try: mkdir -p " . directory
        else
            let directory = substitute(directory, " ", "\\\\ ", "g")
            exec "set " . settingname . "=" . directory
        endif
    endfor

endfunction
call InitializeDirectories()



" Imports
runtime ./plug.vim

