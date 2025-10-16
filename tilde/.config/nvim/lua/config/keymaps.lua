-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
vim.keymap.set("n", "<leader><space>", "<c-^>")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Yank tweaks
vim.keymap.set("n", "<leader>y", '"*y')
vim.keymap.set("v", "<leader>y", '"*y')
vim.keymap.set("n", "<leader>Y", '"*Y')

-- case-insensitive search
vim.keymap.set("n", "?", [[?\v]])
vim.keymap.set("n", "/", [[/\v]])
vim.keymap.set("c", "%s/", [[%sm/]])

-- Copy relative path with line numbers for Claude Code
vim.keymap.set({ "n", "v" }, "<leader>ac", function()
  local filepath = vim.fn.expand("%:.")
  local line_start = vim.fn.line("v")
  local line_end = vim.fn.line(".")

  -- Normalize line range (handle both visual selection directions)
  if line_start > line_end then
    line_start, line_end = line_end, line_start
  end

  local result
  if line_start == line_end then
    result = string.format("@%s:%d", filepath, line_start)
  else
    result = string.format("@%s:%d-%d", filepath, line_start, line_end)
  end

  vim.fn.setreg("+", result)
  vim.fn.setreg("*", result)
  vim.notify("Copied: " .. result, vim.log.levels.INFO)
end, { desc = "Copy path:line for Claude Code" })
