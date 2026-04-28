local later = Config.later

vim.o.clipboard = 'unnamedplus'

-- Change dir when using `nvim some/folder`
vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    local path = vim.fn.expand('%')
    if vim.fn.isdirectory(path) == 1 then
      vim.uv.chdir(path)
    end
  end,
})

-- Fix leader key in some cases
vim.api.nvim_create_autocmd('BufEnter', {
  callback = function()
    vim.schedule(function()
      require('mini.clue').enable_buf_triggers(vim.api.nvim_get_current_buf())
    end)
  end,
})

-- Keybindings
later(function()
  vim.keymap.set('i', 'jk', '<ESC>')
  vim.keymap.set('n', '<leader>\'', '<cmd>Pick resume<CR>', { desc = 'Pick resume' })
  -- Clear search highlights with ESC
  vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR><Esc>')
  -- <C-o> / <C-i> navigate the jump list
  vim.keymap.set('n', '<C-s>', 'm`')
  -- Replace with repeat (https://vonheikemen.github.io/devlog/tools/how-to-survive-without-multiple-cursors-in-vim/)
  vim.keymap.set('v', 'gR', 'y<cmd>let @/=escape(@", \'/\')<cr>"_cgn', { desc = 'Replace with repeat' })

  -- Emacs bindings
  vim.keymap.set('i', '<C-f>', '<Right>')
  vim.keymap.set('i', '<C-b>', '<Left>')
  vim.keymap.set('i', '<C-n>', '<Down>')
  vim.keymap.set('i', '<C-p>', '<Up>')
end)

-- Config for specific filetypes
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = 'en_us,de_de'
  end,
})
vim.filetype.add({
  filename = {
    ['docker-compose.yml'] = 'yaml.docker-compose',
    ['docker-compose.yaml'] = 'yaml.docker-compose',
  },
})

-- Additional plugins

-- Opening lazygit
-- vim.pack.add({ 'https://github.com/kdheepak/lazygit.nvim' })
-- vim.keymap.set('n', '<leader>gg', ':LazyGit<CR>', { desc = "Open lazygit" })
vim.keymap.set("n", "<leader>gg", function()
  vim.fn.jobstart({
    'kitty', '@', 'launch',
    '--type=overlay',
    '--copy-env=yes',
    '--cwd', vim.fn.getcwd(),
    '--',
    'lazygit',
  }, { detach = true })
end, { desc = 'Open lazygit' })

-- Git actions
vim.pack.add({ 'https://github.com/lewis6991/gitsigns.nvim' })
vim.keymap.set('n', '<leader>gr', require('gitsigns').reset_hunk, { desc = 'Reset hunk' })

-- Markdown actions
vim.pack.add({ 'https://github.com/AndrewRadev/switch.vim' })
vim.g.switch_custom_definitions = {
  { -- Cycle markdown checkboxes
    ['^\\(\\s*\\)- \\[ \\] \\(.*\\)'] = '\\1- [-] \\2',
    ['^\\(\\s*\\)- \\[-\\] \\(.*\\)'] = '\\1- [x] \\2',
    ['^\\(\\s*\\)- \\[x\\] \\(.*\\)'] = '\\1- \\2',
    ['^\\(\\s*\\)- \\(.*\\)'] = '\\1- [ ] \\2',
  },
}
vim.keymap.set('n', '<C-CR>', ':Switch<CR>')
vim.keymap.set('i', '<C-CR>', '<ESC>:Switch<CR>A')
