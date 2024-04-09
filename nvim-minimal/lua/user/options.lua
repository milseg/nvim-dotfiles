-- Aesthetics --
vim.opt.cmdheight = 0 -- remove cmdline from screenheight when not used
vim.opt.title = true -- show title
vim.opt.titlestring = '%f // milseg'
vim.opt.termguicolors = true
vim.opt.spell = true -- enable spell checking. Would it be overwritten by lint?
vim.opt.number = true -- enable line numbers
vim.opt.relativenumber = true -- relative to current line
vim.opt.list = true -- show typically hidden character
vim.opt.listchars:append({ tab = '▸ ', trail = '·' })
vim.opt.splitbelow = true -- hsp behavior
vim.opt.splitright = true -- vsp behavior
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8 -- when moving the cursor up and down, shifts screen to show up to 8 lines away from the end of the screen
vim.opt.signcolumn = 'yes:2' -- avoids line column collapse when displaying extra symbols. e.g. linter
vim.opt.shortmess:append({ I = true }) -- disable the splash screen
vim.opt.showmode = false -- Dont need to showmode. Our status bar already solves that


--ident configuration --
vim.opt.expandtab = true -- ident by spaces
vim.opt.shiftwidth = 4 -- amount of spaces used
vim.opt.tabstop = 4 -- tab character width. In case we come across any
vim.opt.softtabstop = 4
vim.opt.smartindent = true -- automatically adds ident after open blocks(e. g. curly braces)

-- text search --
vim.opt.ignorecase = true -- neovim search is set to be case insensitive
vim.opt.smartcase = true -- as soon as you enter a capital letter in your search, it becomes case sensitive

-- Command autocomplete --
vim.opt.wildmode = 'longest:full,full' -- complete the longest common match and allow tabbing the results to fully complete them
vim.opt.completeopt = 'menuone,longest,preview'

-- Mouse --
vim.opt.mouse = 'a' -- enable mouse for all modes
vim.opt.mousemoveevent = true -- Allow hovering in bufferline

-- Clipboard --
vim.opt.clipboard = 'unnamedplus' -- Use system clipboard

-- Backup and history --
vim.opt.undofile = true -- persistent undo
vim.opt.backup = true -- automatically save a backup file
vim.opt.backupdir:remove('.') -- keep backups out of the current directory

-- Other --
-- vim.opt.updatetime = 4001 -- Set updatime to 1ms longer than the default to prevent polyglot from changing it
vim.opt.redrawtime = 10000 -- Allow more time for loading syntax on large files
vim.opt.exrc = true -- If local files ".nvim.lua", ".nvimrc" or".exrc"; Use it as user entry configuration point
vim.opt.secure = true -- give permission to exrc files



