local later = MiniDeps.later

vim.o.clipboard = 'unnamedplus'

-- Keybindings

later(function()
  vim.keymap.set('i', 'jk', '<ESC>')

  -- Clear search highlights with ESC
  vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR><Esc>')

  -- <C-o> / <C-i> navigate the jump list
  vim.keymap.set('n', '<C-s>', 'm`')

  -- Prevent accidental input after using V
  vim.keymap.set('v', 'J', 'j')
  vim.keymap.set('v', 'K', 'k')

  -- Emacs bindings
  vim.keymap.set('i', '<C-f>', '<right>')
  vim.keymap.set('i', '<C-b>', '<left>')
  vim.keymap.set('i', '<C-n>', '<down>')
  vim.keymap.set('i', '<C-p>', '<up>')
end)

-- Config for specific filetypes

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = 'en_us,de_de'
  end,
})
