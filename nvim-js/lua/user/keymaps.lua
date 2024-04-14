--- Leader key ---
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '


--- Fix native UI annoyances ---
-- when text is wrapped, move by terminal rows, not lines, unless a count argument is provided
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", {expr = true})
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", {expr = true})

-- Reselect visual selection after identing.
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- Maintain the cursor position when yanking a visual selection
vim.keymap.set('v', 'y', 'myy`y')

-- Disable command line history console
vim.keymap.set('n', 'q:', ':q<CR>')

-- Paste replace visual selection without copying it
vim.keymap.set('v', 'p', '"_dP')


--- Utilities ---
-- Quickly clear search highlighting
vim.keymap.set('n', '<Leader>k', ':nohlsearch<CR>')

-- Duplicate line
vim.keymap.set('n', '<Leader>d', 'yyA<Esc>p')

-- Move text up and down
vim.keymap.set('i', '<A-j>', '<Esc>:move .+1<CR>==gi')
vim.keymap.set('i', '<A-k>', '<Esc>:move .-2<CR>==gi')
vim.keymap.set('n', '<A-j>', ':move .+1<CR>==')
vim.keymap.set('n', '<A-k>', ':move .-2<CR>==')
vim.keymap.set('v', '<A-j>', ":move '>+1<CR>gv=gv")
vim.keymap.set('v', '<A-k>', ":move '<-2<CR>gv=gv")


--- UI Control ---
-- Decrease file tree split with respect to code window
vim.keymap.set('n', '<C-Left>', ':vertical resize +2<CR>')

-- Increase file tree split with respect to code window
vim.keymap.set('n', '<C-Right>', ':vertical resize -2<CR>')

-- Close all open buffers without closing the editor ---
vim.keymap.set('n', '<leader>Q', ':bufdo bdelete<CR>')


--- Quick file editions ---
-- Remove trailing spaces and indent file ---
vim.keymap.set('n', '<leader>==', ':%s/\\s\\+$//e<CR>ggVG=<C-o>')