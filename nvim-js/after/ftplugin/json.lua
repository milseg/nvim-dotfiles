-- show json path in the winbar
if vim.fn.exists("+winbar") == 1 then
  local ok, jp = pcall(require, "jsonpath")
  if ok then
    vim.opt_local.winbar = "%{%v:lua.require'jsonpath'.get()%}"
  end
end

-- send json path to clipboard
vim.keymap.set("n", "<Leader>cp", function()
  local ok, jp = pcall(require, "jsonpath")
  if ok then
    vim.fn.setreg("+", jp.get())
  end
end, { desc = "copy json path", buffer = true })
