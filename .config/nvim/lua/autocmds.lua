
-- local format_group = vim.api.nvim_create_augroup("Format", { clear = true })
-- vim.api.nvim_create_autocmd({"BufWritePost"}, {
--   pattern = "*",
--   command = 'normal! gg=G``',
--   group = format_group
-- })

-- Open help window in a vertical split to the right.
-- vim.api.nvim_create_autocmd("BufWinEnter", {
--     group = vim.api.nvim_create_augroup("HelpWindowLeft", {}),
--     pattern = { "*.txt" },
--     callback = function()
--         if vim.o.filetype == 'help' then vim.cmd.wincmd("H") end
--     end
-- })
--

-- highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  pattern = '*',
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
})

-- stash the IM when switching modes
local input_method_group = vim.api.nvim_create_augroup('InputMethod', { clear = true })
IM="keyboard-us" -- current input method
vim.api.nvim_create_autocmd({ "InsertLeave" }, {
  pattern = "*",
  callback = function()
    IM = tostring(vim.fn.system("fcitx5-remote -n"))
    vim.fn.system("fcitx5-remote -c")
  end,
  group = input_method_group,
})

vim.api.nvim_create_autocmd({ "InsertEnter" }, {
  pattern = "*",
  callback = function()
    vim.fn.system("fcitx5-remote -s" .. IM)
  end,
  group = input_method_group,
})

-- 自动切换目录
-- vim.cmd [[ autocmd BufWinEnter * lcd %:p:h ]]
