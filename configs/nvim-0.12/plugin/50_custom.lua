local later = Config.later

vim.o.clipboard = 'unnamedplus'

-- Init correctly when using `nvim some/folder`
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local path = vim.fn.expand("%")
    if vim.fn.isdirectory(path) == 1 then
      vim.cmd("cd " .. vim.fn.fnameescape(path))
      -- Fix leader key after closing mini.files
      vim.cmd("bwipeout " .. vim.api.nvim_get_current_buf())
    end
  end,
})

-- Keybindings

later(function()
  vim.keymap.set('i', 'jk', '<ESC>')
  vim.keymap.set('n', '<leader>\'', '<cmd>Pick resume<CR>')
  -- Clear search highlights with ESC
  vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR><Esc>')
  -- <C-o> / <C-i> navigate the jump list
  vim.keymap.set('n', '<C-s>', 'm`')

  -- Emacs bindings
  vim.keymap.set('i', '<C-f>', '<right>')
  vim.keymap.set('i', '<C-b>', '<left>')
  vim.keymap.set('i', '<C-n>', '<down>')
  vim.keymap.set('i', '<C-p>', '<up>')
  -- for _, mode in ipairs({ 'n', 'v', 'i' }) do
  --   vim.keymap.set(mode, '<C-a>', function()
  --     local col = vim.fn.col('.') - 1
  --     vim.cmd(col == vim.fn.indent('.') and 'normal! 0' or 'normal! ^')
  --   end)
  --   vim.keymap.set(mode, '<C-e>', '<End>')
  -- end
end)

-- Config for specific filetypes

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = 'en_us,de_de'
  end,
})
