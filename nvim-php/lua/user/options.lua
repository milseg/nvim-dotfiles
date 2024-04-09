
vim.opt.cmdheight = 0 -- remove cmdline from screenheight when not used

--ident configuration --
vim.opt.expandtab = true -- ident by spaces
vim.opt.shiftwidth = 4 -- amount of spaces used
vim.opt.tabstop = 4 -- tab character width. In case we come across any
vim.opt.softtabstop = 4

vim.opt.smartindent = true -- automatically adds ident after open blocks(e. g. curly braces)

vim.opt.wrap = false -- disable line wrap

vim.opt.number = true -- enable line numbers
vim.opt.relativenumber = true -- make line numbers relative to current line

vim.opt.wildmode = 'longest:full,full' -- complete the longest common match and allow tabbing the results to fully complete them
vim.opt.completeopt = 'menuone,longest,preview'

vim.opt.title = true
vim.opt.mouse = 'a' -- enable mouse for all modes

vim.opt.termguicolors = true -- enable the full array of colors

vim.opt.spell = true -- enable spell checking

vim.opt.ignorecase = true -- neovim search is set to be case insensitive
vim.opt.smartcase = true -- as soon as you enter a capital letter in your search, it becomes case sensitive


-- unhiding invisible characters --
vim.opt.list = true
vim.opt.listchars:append({ tab = '▸ ', trail = '·' })

-- vim.opt.fillchars:append({eob = ' '}) -- remove the ~ characters from the end of buffer

-- split preferences --
vim.opt.splitbelow = true
vim.opt.splitright = true

-- when moving the cursor up and down, shifts screen to show up to 8 lines away from the end of the screen --
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8


vim.opt.clipboard = 'unnamedplus' -- Use system clipboard

-- vim.opt.confirm = true -- ask for confirmation instead of erroring(e. g. when quitting)

vim.opt.signcolumn = 'yes:2'


vim.opt.undofile = true -- persistent undo history through multiple sessions
vim.opt.backupdir:remove('.') -- keep backups out of current directory
