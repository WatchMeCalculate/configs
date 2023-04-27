vim.cmd("autocmd!")
vim.opt.clipboard:append { 'unnamedplus' }

vim.scriptencoding= 'utf-8'
vim.opt.encoding= 'utf-8'
vim.opt.fileencoding= 'utf-8'
vim.opt.termguicolors= true
vim.opt.syntax= 'enable'


vim.opt.mouse= 'a'
vim.opt.mousehide= true
vim.opt.history= 1000

vim.opt.iskeyword:append('.')
vim.opt.iskeyword:append('#')
vim.opt.iskeyword:append('-')

vim.opt.backup= true
vim.opt.undofile= true
vim.opt.undolevels= 1000
vim.opt.undoreload= 10000

vim.opt.tabpagemax= 15

vim.opt.ruler= true
vim.cmd([[
  set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%)
]])
vim.opt.showcmd= true

vim.opt.backspace= {'indent', 'eol','start'}
-- No extra spaces between rows
vim.opt.linespace= 0
vim.wo.number= true
-- Show matching brackets/parenthesis
vim.opt.showmatch= true
-- Find as you type search
vim.opt.incsearch= true
-- Highlight search terms
vim.opt.hlsearch= true
-- Windows can be 0 line high
vim.opt.winminheight= 0
vim.opt.ignorecase= true
vim.opt.smartcase= true
-- Lines to scroll when cursor leaves screen
vim.opt.scrolljump= 5
-- Minimum lines to keep above and below cursor
vim.opt.scrolloff= 3
vim.opt.foldenable= true
vim.opt.list= true
vim.opt.smarttab= true

vim.opt.wrap= false
vim.opt.autoindent= true
vim.opt.smartindent= true
vim.opt.breakindent= true
vim.opt.shiftwidth= 2
vim.opt.tabstop= 2
vim.opt.expandtab= true

-- Puts new vsplit windows to the right of the current
vim.opt.splitright= true
-- Puts new split windows to the bottom of the current
vim.opt.splitbelow= true

vim.opt.pastetoggle= '<F12>'

vim.opt.path:append { '**' }
vim.opt.wildignore:append { '*/node_modules/*' }

vim.opt.lazyredraw= true

vim.cmd("nnoremap Y y$")

-- Change working directory to that of current file
vim.opt.autochdir= true

-- sudo write
vim.cmd("cmap w!! w !sudo tee %>/dev/null")

vim.cmd([[
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
]])
